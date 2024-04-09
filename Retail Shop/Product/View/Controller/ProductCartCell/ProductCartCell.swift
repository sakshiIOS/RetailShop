//
//  ProductCartCell.swift
//  Retail Shop
//
//  Created by Sakshi Singh on 04/04/24.
//

import UIKit

class ProductCartCell: UITableViewCell {
    
    
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var productImageView: UIImageView!

    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var quantityLabe2: UILabel!

    @IBOutlet weak var priceLabel: UILabel!
    
    var product: CartProducts? {
        didSet { // Property Observer
            productDetailConfiguration()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func productDetailConfiguration() {
        guard let product else { return }
        productTitleLabel.text = product.title
        productCategoryLabel.text = product.category
        quantityLabel.text = "1"
        quantityLabe2.text = "Quantity - 1"
        priceLabel.text = "$\(product.price )"
      //  rateButton.setTitle("\(product.rating ?? 0)", for: .normal)
        productImageView.setImage(with: product.images ?? "")
        
    }
}
