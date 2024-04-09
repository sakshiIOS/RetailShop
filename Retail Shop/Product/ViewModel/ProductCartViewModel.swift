//
//  ProductCartViewModel.swift
//  Retail Shop
//
//  Created by Sakshi Singh on 04/04/24.
//

import Foundation


final class ProductCartViewModel{
    
    var productCart = [CartProducts]()
    func fetchCartItems(){
        
        if !DatabaseHelper.sharedInstance.fetch().isEmpty{
            self.productCart = DatabaseHelper.sharedInstance.fetch()
            print(self.productCart.count)
        }else{
            self.productCart = []
        }
        
    }
}
