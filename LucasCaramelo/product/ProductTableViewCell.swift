//
//  ProductTableViewCell.swift
//  LucasCaramelo
//
//  Created by Usuário Convidado on 23/04/18.
//  Copyright © 2018 fiap. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    // Mark: Outlet's
    
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbState: UILabel!
    @IBOutlet weak var lbValue: UILabel!
    
    var product: Product! {
        didSet {
            setupViews()
        }
    }
    
    private func setupViews() {
        lbName.text = product.name
        lbValue.text = product.value.toCurrencyString(forLocale: .EN, useSymbol: true)
    }
}
