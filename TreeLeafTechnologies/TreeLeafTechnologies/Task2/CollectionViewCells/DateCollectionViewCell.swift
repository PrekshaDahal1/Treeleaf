//
//  DateCollectionViewCell.swift
//  TreeLeafTechnologies
//
//  Created by Preksha Dahal on 30/12/2023.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayouts()
    }
    
     required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Components of cell
    lazy var lblDateFormat: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Date Format"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var lblConvertedDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "MM/DD/YYYY"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 4
        stackView.alignment = .leading
        stackView.addArrangedSubview(lblDateFormat)
        stackView.addArrangedSubview(lblConvertedDate)
        return stackView
    }()
    
    //MARK: - AutoLayout of the constraints
    func setUpLayouts() {
        autoLayoutOFDateFormat()
    }
    
    func autoLayoutOFDateFormat() {
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}
