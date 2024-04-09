//
//  ProductLists.swift
//  Retail Shop
//
//  Created by Sakshi Singh on 02/04/24.
//

import Foundation


//// MARK: - ProductList
//struct ProductList: Codable {
//    let id: Int?
//    let title, description: String?
//    let price: Int?
//    let discountPercentage, rating: Double?
//    let stock: Int?
//    var brand, category: String?
//    let thumbnail: String?
//    let images: [String]?
//}


//// MARK: - ProductList
struct ProductList: Codable {
    let products: [Product]?
    let total, skip, limit: Int?
}

// MARK: - Product
struct Product: Codable {
    let id: Int?
    let title, description: String?
    let price: Int?
    let discountPercentage, rating: Double?
    let stock: Int?
    let brand, category: String?
    let thumbnail: String?
    let images: [String]?
}
