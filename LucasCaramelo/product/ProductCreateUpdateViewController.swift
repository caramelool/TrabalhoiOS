//
//  ProductCreateUpdateViewController.swift
//  LucasCaramelo
//
//  Created by Lucas Caramelo on 24/04/2018.
//  Copyright © 2018 fiap. All rights reserved.
//

import UIKit

class ProductCreateUpdateViewController: UIViewController {
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var tfState: UITextField!
    @IBOutlet weak var tfValue: UITextField!
    @IBOutlet weak var swCard: UISwitch!
    @IBOutlet weak var btSave: UIButton!
    
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if product != nil {
            tfName.text = product.name
//            tfValue.text = String(product.value)
            swCard.setOn(product.credit, animated: false)
//            if let state = product.state as? State {
//                tfState.text = state.name
//            }
//            if let image = product.image as? UIImage {
//                ivImage.image = image
//            }
            btSave.setTitle("Salvar", for: .normal)
        } else {
            btSave.setTitle("Cadastrar", for: .normal)
        }
    }
    
    @IBAction func save(_ sender: UIButton) {
        if product == nil {
            product = Product(context: context)
        }
        product.name = tfName.text
        product.credit = swCard.isOn
        let saved = ProductManager.shared.save(product)
        if saved {
            navigationController?.popViewController(animated: true)
        } else {
            showAlertOK(title: "Error", message: "Não foi possivel \(btSave.titleLabel?.text ?? "") seu produto")
            let _ = ProductManager.shared.delete(product)
        }
    }
    
}
