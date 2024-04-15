//
//  ProductListVC.swift
//  Retail Shop
//
//  Created by Sakshi Singh on 02/04/24.

//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with urlString: String) {
        guard let url = URL.init(string: urlString) else {
            return
        }
        let resource = KF.ImageResource(downloadURL: url, cacheKey: urlString)
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
    

    func imageFromServerURL(urlString: String, PlaceHolderImage:UIImage) {

            if self.image == nil{
                  self.image = PlaceHolderImage
            }

            URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in

                if error != nil {
                    print(error ?? "No Error")
                    return
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    let image = UIImage(data: data!)
                    self.image = image
                })

            }).resume()
        }
}

