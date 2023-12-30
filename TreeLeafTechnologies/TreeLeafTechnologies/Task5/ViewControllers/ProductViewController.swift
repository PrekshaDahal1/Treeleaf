//
//  ProductViewController.swift
//  TreeLeafTechnologies
//
//  Created by Preksha Dahal on 30/12/2023.
//

import UIKit

class ProductViewController: UIViewController {
    
    //MARK: - Variables
    var products = [Product]()
    
    //MARK: - Initialization of UI Components
    lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ("Popular Items")
        label.font = UIFont.systemFont(ofSize: 26)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var tblProducts: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProductTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        return tableView
        
    }()
    
    //MARK: - TableView Cell Configuration
    func cellConfiguration() {
        let product1 = Product(itemName: "B1", itemDesc: "Lorem Ipsum ansdhgj", imgItem: UIImage(named: "B1")!, isAddedToCart: false)
        let product2 = Product(itemName: "B2", itemDesc: "Lorem Ipsum ansdhgj", imgItem: UIImage(named: "B4")!, isAddedToCart: false)
        let product3 = Product(itemName: "B3", itemDesc: "Lorem Ipsum ansdhgj", imgItem: UIImage(named: "B3")!, isAddedToCart: false)
        let product4 = Product(itemName: "B4", itemDesc: "Lorem Ipsum ansdhgj", imgItem: UIImage(named: "B2")!, isAddedToCart: false)
        let product5 = Product(itemName: "B4", itemDesc: "Lorem Ipsum ansdhgj", imgItem: UIImage(named: "B1")!, isAddedToCart: false)
        let product6 = Product(itemName: "B4", itemDesc: "Lorem Ipsum ansdhgj", imgItem: UIImage(named: "B2")!, isAddedToCart: false)
        let product7 = Product(itemName: "B4", itemDesc: "Lorem Ipsum ansdhgj", imgItem: UIImage(named: "B3")!, isAddedToCart: false)
        
        products.append(product1)
        products.append(product2)
        products.append(product3)
        products.append(product4)
        products.append(product5)
        products.append(product6)
        products.append(product7)
       
        tblProducts.reloadData()
    }
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        cellConfiguration()
        setUpLayout()
        view.backgroundColor = UIColor.white
    }
    
    
    //MARK: - AutoLayot
    func setUpLayout() {
        autoLayoutForLabel()
        autoLayoutForTableView()
    }
    
    func autoLayoutForLabel() {
        view.addSubview(lblTitle)
        NSLayoutConstraint.activate([
            lblTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            lblTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lblTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func autoLayoutForTableView() {
        view.addSubview(tblProducts)
        NSLayoutConstraint.activate([
            tblProducts.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 20),
            tblProducts.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tblProducts.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tblProducts.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.9)
        ])
    }
}

//MARK: - Table View extension
extension ProductViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        
        cell.product = products[indexPath.row]
        cell.layer.cornerRadius = 12
        cell.layer.borderColor = UIColor(Color.pink).cgColor
        cell.layer.borderWidth = 1
        
//        cell.image = imgProducts[indexPath.row]
//        cell.lblProductName.text = lblName[indexPath.row]
//        cell.lblProductDesc.text = lblDesc[indexPath.row]
//
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 180
        }
}

//MARK: - Protocol Implementation
extension ProductViewController: ProductCellDelegate {
    func AddToCartTapped(cell: ProductTableViewCell) {
        guard let product = cell.product else { return }
        
        if product.isAddedToCart {
            cell.btnAddToCart.btnConfigure(isAddedToCart: false)
        }
        else {
            cell.btnAddToCart.btnConfigure(isAddedToCart: true)
        }
        
        cell.product?.isAddedToCart = !product.isAddedToCart
        
    }
}
