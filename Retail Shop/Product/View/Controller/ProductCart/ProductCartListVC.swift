//
//  ProductCartListVC.swift
//  Retail Shop
//
//  Created by Sakshi Singh on 04/04/24.
//

import UIKit

class ProductCartListVC: UIViewController {
    
    
    // MARK: - Outlets
    @IBOutlet weak var productCartTableView: UITableView!
    @IBOutlet weak var lblCartValue: UILabel!

    private var viewModel = ProductCartViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.configurationCartCell()
    }
    
    func configurationCartCell() {
 
        self.productCartTableView.register(UINib(nibName: "ProductCartCell", bundle: nil), forCellReuseIdentifier: "ProductCartCell")
        self.initViewModel()
     
    }
    
    func initViewModel(){
        self.viewModel.fetchCartItems()
        self.UIProductCart()
    }

    func UIProductCart(){
        
        if viewModel.productCart.isEmpty{
            self.lblCartValue.isHidden = true
            self.lblCartValue.clipsToBounds = true
            self.lblCartValue.layer.cornerRadius = 10
            self.productCartTableView.isHidden = true
        }else{
            self.productCartTableView.isHidden = false
            self.lblCartValue.isHidden = false
            self.lblCartValue.clipsToBounds = true
            self.lblCartValue.layer.cornerRadius = 10
            self.lblCartValue.text = "\(viewModel.productCart.count)"
        }
        
      
     }
    //MARK: - @IBAction
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnAdd(sender: UIButton){
       
        
        AKAlertController.alert("Only 1 Quantity can be added")
    }
    
    @objc func btnMinus(sender: UIButton){
        let cartDataIndices = self.viewModel.productCart.indices.filter{self.viewModel.productCart[$0].id == viewModel.productCart[sender.tag].id}
        
        if !cartDataIndices.isEmpty{
            AKAlertController.alert("Warning", message: "Product will remove from cart", buttons: ["Cancel","OK"]) { _ , _ , index  in
                
                if index == 1{
                    
                    
                    DatabaseHelper.sharedInstance.deleteIndexValue(index: cartDataIndices,cartData: self.viewModel.productCart)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        
    }

}
extension ProductCartListVC: UITableViewDataSource,UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return viewModel.productCart.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCartCell") as! ProductCartCell
        cell.product = viewModel.productCart[indexPath.row]
        cell.minusButton.tag = indexPath.row
        cell.minusButton.addTarget(self, action: #selector(btnMinus(sender:)), for: .touchUpInside)
        cell.addButton.addTarget(self, action: #selector(btnAdd(sender:)), for: .touchUpInside)
        return cell
    }
    
   

}
