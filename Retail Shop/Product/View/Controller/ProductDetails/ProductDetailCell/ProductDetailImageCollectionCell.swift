//
//  ProductDetailImageCollectionCell.swift
//  Retail Shop
//
//  Created by Sakshi Singh on 03/04/24.
//

import UIKit
import Kingfisher

class ProductDetailImageCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    
    var product: Product? {
        didSet { // Property Observer
            productDetailConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func productDetailConfiguration() {
        guard let product else { return }
        for i in 0..<(product.images?.count ?? 0){
           // productImageView.imageFromServerURL(urlString: product.images?[i] ?? "", PlaceHolderImage: UIImage.init(named: "ImagePlaceHolder")!)
            productImageView.setImage(with: product.images?[i] ?? "")
        }
    }
}
