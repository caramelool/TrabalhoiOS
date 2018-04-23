//
//  ViewController.swift
//  LucasCaramelo
//
//  Created by Usuário Convidado on 23/04/18.
//  Copyright © 2018 fiap. All rights reserved.
//

import UIKit

class ProductTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var products: [Product] = []
    private var emptyLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 22))
        label.text = "Sua lista está vazia!"
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

extension ProductTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell") as! ProductTableViewCell
        
        return cell
    }
}

extension ProductTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = products.count
        tableView.backgroundView = count == 0 ? emptyLabel : nil
        return count
    }
}
