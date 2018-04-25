//
//  ProductDAO.swift
//  LucasCaramelo
//
//  Created by Lucas Caramelo on 24/04/2018.
//  Copyright © 2018 fiap. All rights reserved.
//

import UIKit
import CoreData

class ProductManager {
    
    static let shared = ProductManager()
    private var context: NSManagedObjectContext!
    
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    func load(callback: ([Product]?, Error?) -> ()){
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let products = try context.fetch(fetchRequest)
            callback(products, nil)
        } catch {
            print(error.localizedDescription)
            callback(nil, error)
        }
    }
    
    func save(_ product: Product) -> Bool {
        do {
            try context.save()
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func delete(_ product: Product) -> Bool {
        do {
            context.delete(product)
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
}
