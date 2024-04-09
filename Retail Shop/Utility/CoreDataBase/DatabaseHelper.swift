//
//  DatabaseHelper.swift
//  DemoDatabase
//
//  Created by Sakshi Singh on 05/09/21.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper {
    static var sharedInstance = DatabaseHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    func save(object:[String:Any]){
        
        let product = NSEntityDescription.insertNewObject(forEntityName: "CartProducts", into: context!) as? CartProducts
        product?.brand = (object["brand"] as? String)!
        product?.id = (object["id"] as! Int64)
        product?.category = (object["category"] as? String)!
        product?.title = (object["title"] as? String)!
        product?.price = (object["price"] as! Int64)
        product?.images = (object["images"] as? String)!

       do {
            try context?.save()
        } catch  {
            
            print("error")
        }
    }
    
    func fetch()->[CartProducts]{
        
        var productData: [CartProducts]!
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CartProducts")
                    
            do {
                productData = try context?.fetch(fetchRequest) as? [CartProducts]
               

            } catch {
              print("Co")
            }
        return productData
    }
    
    func deleteIndexValue(index:[Int],cartData:[CartProducts])->[CartProducts]{
        
        var outsgesData = [CartProducts] ()
        outsgesData = cartData
        do {
            if let result = outsgesData as? [CartProducts] {
                for _ in result {
                    let objectUpdate = outsgesData as [NSManagedObject]
                    
                    for i in 0..<index.count{
                        context?.delete(objectUpdate[index[i]])
                        
                    }
                }
            }
            try context?.save()
        } catch {
            print("Co")
        }
        return outsgesData
    }
    
}
