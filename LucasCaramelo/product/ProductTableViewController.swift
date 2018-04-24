//
//  ViewController.swift
//  LucasCaramelo
//
//  Created by Usuário Convidado on 23/04/18.
//  Copyright © 2018 fiap. All rights reserved.
//

import UIKit

class ProductTableViewController: UITableViewController {

    // MARK: Local variables
    
    private var products: [Product] = []
    private let emptyLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 22))
        label.text = "Sua lista está vazia!"
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    private let indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        indicator.color = .black
        return indicator
    }()
    private var isLoading: Bool = false
    
    // MARK: ViewController functions
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadProducts()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ProductCreateUpdateViewController {
            if let cell = sender as? ProductTableViewCell {
                vc.product = cell.product
            }
        }
    }
    
    // MARK: TableView functions
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell") as! ProductTableViewCell
        cell.product = products[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isLoading ? 0 : products.count
    }
    
    // MARK: Class functions
    
    private func showLoading(_ show: Bool) {
        isLoading = show
        tableView.backgroundView = indicatorView
        if show { indicatorView.startAnimating() }
        else {
            indicatorView.stopAnimating()
            tableView.backgroundView = products.count == 0 ? emptyLabel : nil
        }
        tableView.reloadData()
    }
    
    func loadProducts() {
        showLoading(true)
        ProductDAO.load { (products, error) in
            if error == nil {
                guard let products = products else { return }
                self.products = products
            } else {
                print(error ?? "")
            }
            self.showLoading(false)
        }
    }

}
