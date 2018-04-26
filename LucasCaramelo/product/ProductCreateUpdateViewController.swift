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
    var statePickerView: UIPickerView!
    
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if product != nil {
            tfName.text = product.name
            tfValue.text = product.value.toCurrencyString()
            swCard.setOn(product.credit, animated: false)
            if let state = product.state as? State {
                tfState.text = state.name
            }
            if let image = product.image as? UIImage {
                ivImage.image = image
            }
            btSave.setTitle("Salvar", for: .normal)
        } else {
            btSave.setTitle("Cadastrar", for: .normal)
        }
        setupImageView()
        setupStatePicker()
    }
    
    private func setupImageView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage(tapGestureRecognizer:)))
        ivImage.isUserInteractionEnabled = true
        ivImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setupStatePicker() {
        statePickerView = UIPickerView()
        statePickerView.backgroundColor = .white
        statePickerView.delegate = self
        statePickerView.dataSource = self
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
        
        let btCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let btSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let btDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.items = [btCancel, btSpace, btDone]
        
        tfState.inputView = statePickerView
        tfState.inputAccessoryView = toolbar
    }
    
    @objc func selectImage(tapGestureRecognizer: UITapGestureRecognizer){
        print("TAP")
    }
    
    @objc func cancel() {
        tfState.resignFirstResponder()
    }
    
    @objc func done() {
        let row = statePickerView.selectedRow(inComponent: 0)
        tfState.text = pickerView(statePickerView, titleForRow: row, forComponent: 0)
        cancel()
    }
    
    @IBAction func save(_ sender: UIButton) {
        if product == nil {
            product = Product(context: context)
        }
        product.name = tfName.text
        product.value = tfValue.text?.toCurrencyDouble() ?? 0
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

extension ProductCreateUpdateViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //Retornando o texto recuperado do objeto dataSource, baseado na linha selecionada
        return String(row)
    }
}

extension ProductCreateUpdateViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
}
