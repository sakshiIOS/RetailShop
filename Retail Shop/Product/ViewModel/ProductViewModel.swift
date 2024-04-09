//
//  ProductViewModel.swift
//  Retail Shop
//
//  Created by Sakshi Singh on 02/04/24.
//

import Foundation


final class ProductViewModel{
    
    
    var products: [Product] = []
    var productCart = [CartProducts]()
  
    var eventHandler: ((_ event:Event) -> Void)?
    
    func fetchProduct(){
        self.eventHandler?(.loading)
        
        APIManager.shared.requestDataAPI(){ result in
            self.eventHandler?(.stoploading)
            switch result{
            case .success(let product):
                self.products = product.products!
             
                self.eventHandler?(.dataLoaded)
                print(product)
           
            case .failure(let error):
                
                self.eventHandler?(.error(error))
                print(error)
            }
        }
    }
    
    //MARK: - Database saving
    
    func fetchCartItems(){
        
        if !DatabaseHelper.sharedInstance.fetch().isEmpty{
            self.productCart = DatabaseHelper.sharedInstance.fetch()
            print(self.productCart.count)
        }else{
            self.productCart = []
        }
        
    }

   
}

extension ProductViewModel{
    
    enum Event{
         
        case loading
        case stoploading
        case dataLoaded
        case error(Error?)
    }
}
