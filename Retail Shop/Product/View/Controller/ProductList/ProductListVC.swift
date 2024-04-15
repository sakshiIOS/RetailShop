//
//  ProductListVC.swift
//  Retail Shop
//
//  Created by Sakshi Singh on 02/04/24.
//

import UIKit


class ProductListVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var lblCartValue: UILabel!

    private var viewModel = ProductViewModel()

  

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.configurationProductCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.fetchCartItems()
        self.UIProduct()
    }
    

    func configurationProductCell() {
      self.productTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        self.observeEvent()
        self.initViewModel()
        self.UIProduct()
    }
    
    func initViewModel(){
        
        self.viewModel.fetchProduct()
        self.viewModel.fetchCartItems()
    }
    
    func UIProduct(){
        
        if viewModel.productCart.isEmpty{
            self.lblCartValue.isHidden = true

            self.lblCartValue.clipsToBounds = true
            self.lblCartValue.layer.cornerRadius = 10
        }else{
            self.lblCartValue.isHidden = false

            self.lblCartValue.clipsToBounds = true
            self.lblCartValue.layer.cornerRadius = 10
            self.lblCartValue.text = "\(viewModel.productCart.count)"
        }
      
     }
    //Data binding means comminucation b/w viewModel to View
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }

            switch event {
            case .loading:
                DispatchQueue.main.async {
                    self.LoadingStart()
                }
                /// Indicator show
                print("Product loading....")
            case .stoploading:
                DispatchQueue.main.async {
                    self.LoadingStop()
                }

                print("Stop loading...")
            case .dataLoaded:
                print("Data loaded...")
                DispatchQueue.main.async {
                    self.LoadingStop()
                }
                DispatchQueue.main.async {
                    // UI Main works well
                    self.productTableView.reloadData()
                }
            case .error(let error):
                print(error as Any)
         
            }
        }
    }
    
    //MARK: - @IBAction
    
    @IBAction func cartAction(_ sender: Any) {
        
        let vc = ProductCartListVC.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
   
}

extension ProductListVC: UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return viewModel.products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as! ProductCell
        let product = viewModel.products[indexPath.row]
        cell.product = product
        return cell
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

         print("Tap For Detail Page ")
         let vc = ProductDetailsVC.instantiate(fromAppStoryboard: .Main)
         vc.products = viewModel.products[indexPath.row]
         self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
