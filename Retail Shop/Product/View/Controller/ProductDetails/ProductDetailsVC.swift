//
//  ProductDetailsVC.swift
//  Retail Shop
//
//  Created by Sakshi Singh on 03/04/24.
//

import UIKit

class ProductDetailsVC: UIViewController {
    
    
    // MARK: - Outlets
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblBrand: UILabel!
    
    @IBOutlet weak var addCartButton: UIButton!
    @IBOutlet weak var rateButton: UIButton!
    
    var products:Product?
    private var viewCartModel = ProductCartViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.configurationDetailCell()
    }
    
    
    
    func configurationDetailCell() {
        
        let nib = UINib(nibName: "ProductDetailImageCollectionCell", bundle: nil)
        productCollectionView.register(nib, forCellWithReuseIdentifier: "ProductDetailImageCollectionCell")
        
        self.viewCartModel.fetchCartItems()
        self.productDetails()
    }
    
    
    func productDetails(){
        
        self.lblTitle.text = "\(products?.title ?? "")"
        self.lblDetails.text = products?.description ?? ""
        self.rateButton.setTitle("\(products?.rating ?? 0)", for: .normal)
        self.lblBrand.text = "Brand - \(products?.brand ?? "") (\(products?.category ?? ""))"
        let cartData = viewCartModel.productCart.filter{$0.id == products?.id ?? 0}
        if !cartData.isEmpty{
            self.addCartButton.setTitle("Remove", for: .normal)
            
        }else{
            self.addCartButton.setTitle("Add to Cart", for: .normal)
        }
    }
    
    //MARK: - Database saving
    func saveInDataBase(selectedProduct:Product){
        let cartData = self.viewCartModel.productCart.filter{$0.id == selectedProduct.id ?? 0}
        let cartDataIndices = self.viewCartModel.productCart.indices.filter{self.viewCartModel.productCart[$0].id  == selectedProduct.id ?? 0}
        if cartData.isEmpty{
            let selectedProduct = ["title":selectedProduct.title ?? "","brand":selectedProduct.brand ?? "","id":Int64(selectedProduct.id ?? 0),"price":Int64(selectedProduct.price ?? 0),"category":selectedProduct.category ?? "","images":selectedProduct.thumbnail ?? ""] as [String : Any]
            
            AKAlertController.alert("", message: "Item Added to Cart", buttons: ["Cancel","OK"]) { _ , _ , index  in
                
                DatabaseHelper.sharedInstance.save(object: selectedProduct)
                
                self.navigationController?.popViewController(animated: true)
                
            }
            
        }else{
            
            AKAlertController.alert("Warning", message: "Already added to Cart due you want to remove", buttons: ["Cancel","OK"]) { _ , _ , index  in
                
                if index == 1{
                    DatabaseHelper.sharedInstance.deleteIndexValue(index: cartDataIndices,cartData: self.viewCartModel.productCart)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        
    }
    
    //MARK: - @IBAction
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddToCart(_sender: Any){
        
        DispatchQueue.main.async {
            
            self.saveInDataBase(selectedProduct: self.products!)
        }
    }
}
extension ProductDetailsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.pageControl.numberOfPages = products?.images?.count ?? 0
        
        return products?.images?.count ?? 0
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductDetailImageCollectionCell", for: indexPath) as! ProductDetailImageCollectionCell
        cell.product = products
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width , height: 150.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard  scrollView == productCollectionView else { return }
        
        let pageWidth = scrollView.frame.width
        let pageNumber = Int(self.productCollectionView.contentOffset.x / pageWidth)
        
        self.pageControl.currentPage = pageNumber
    }
    
}
