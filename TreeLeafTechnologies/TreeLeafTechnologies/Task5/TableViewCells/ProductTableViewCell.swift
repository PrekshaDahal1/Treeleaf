//
//  ProductTableViewCell.swift
//  TreeLeafTechnologies
//
//  Created by Preksha Dahal on 30/12/2023.
//

import UIKit

protocol ProductCellDelegate {
    
    func AddToCartTapped(cell: ProductTableViewCell)
    
}

class ProductTableViewCell: UITableViewCell {
    
    //MARK: - Variables and const
    var delegate: ProductCellDelegate?

    var product: Product? {
        didSet {
            guard let product = product else { return }
            imgProduct.image = product.imgItem
            lblProductName.text = product.itemName
            lblProductDesc.text = product.itemDesc
        }
    }
    
    //MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI components
    lazy var imgProduct: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var lblProductName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ("Popular Items")
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var lblProductDesc: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ("Popular Items")
        label.font = UIFont.systemFont(ofSize: 12)
        label.tintColor = UIColor.gray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var btnAddToCart: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add To Cart", for: .normal)
        button.backgroundColor = UIColor.systemPink
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.addTarget(self, action: #selector(addToCartTap), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        stackView.alignment = .leading
        stackView.addArrangedSubview(lblProductName)
        stackView.addArrangedSubview(lblProductDesc)
        return stackView
    }()
    
    //MARK: - AutoLayouts of Constraints
    func setUpLayout() {
        self.autoLayoutForImage()
        self.autoLayoutForStackView()
        self.autoLayoutForBtn()
    }
    
    func autoLayoutForImage() {
        contentView.addSubview(imgProduct)
        NSLayoutConstraint.activate([
            imgProduct.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imgProduct.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            imgProduct.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
            imgProduct.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4),
        ])
    }
    
    func autoLayoutForStackView() {
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: imgProduct.trailingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            stackView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
        ])
    }
    
    func autoLayoutForBtn() {
        contentView.addSubview(btnAddToCart)
        NSLayoutConstraint.activate([
        
            btnAddToCart.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            btnAddToCart.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            btnAddToCart.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.25),
            btnAddToCart.topAnchor.constraint(equalTo: imgProduct.bottomAnchor, constant: 5)
            
        ])
    }
    
    //MARK: - ButtonTap Actions
    @objc func addToCartTap() {
        delegate?.AddToCartTapped(cell: self)
    }
}

//MARK: - Button extensions
extension UIButton {
    func btnConfigure(isAddedToCart: Bool) {
        if isAddedToCart {
            self.setTitle("Remove from cart", for: .normal)
            self.backgroundColor = UIColor.lightGray
            self.setTitleColor(UIColor.white, for: .normal)
            self.layer.cornerRadius = 8
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOpacity = 0.5
            self.layer.shadowOffset = CGSize(width: 0, height: 2)
            self.layer.shadowRadius = 4
            
        } else {
            self.setTitle("Add To Cart", for: .normal)
            self.backgroundColor = UIColor.systemPink
            self.setTitleColor(UIColor.white, for: .normal)
            self.layer.cornerRadius = 8
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOpacity = 0.5
            self.layer.shadowOffset = CGSize(width: 0, height: 2)
            self.layer.shadowRadius = 4
        }
    }
    
}
