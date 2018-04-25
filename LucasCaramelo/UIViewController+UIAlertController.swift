//
//  UIViewController+UIAlertController.swift
//  LucasCaramelo
//
//  Created by Usuário Convidado on 25/04/18.
//  Copyright © 2018 fiap. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlertOK(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
