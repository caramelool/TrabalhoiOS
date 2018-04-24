//
//  ProductDAO.swift
//  LucasCaramelo
//
//  Created by Lucas Caramelo on 24/04/2018.
//  Copyright © 2018 fiap. All rights reserved.
//

import Foundation
import CoreData

struct ProductDAO {
    
    static func load(callback: ([Product]?, Error?) -> ()){
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let products = try context.fetch(fetchRequest)
            callback(products, nil)
        } catch {
            callback(nil, error)
        }
    }
    
}
