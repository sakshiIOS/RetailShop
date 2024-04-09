//
//  CartProducts+CoreDataProperties.swift
//  Retail Shop
//
//  Created by Sakshi Singh on 03/04/24.
//
//

import Foundation
import CoreData


extension CartProducts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartProducts> {
        return NSFetchRequest<CartProducts>(entityName: "CartProducts")
    }

    @NSManaged public var title: String?
    @NSManaged public var brand: String
    @NSManaged public var id: Int64
    @NSManaged public var price: Int64
    @NSManaged public var category: String?
    @NSManaged public var images: String?

}

extension CartProducts : Identifiable {

}
