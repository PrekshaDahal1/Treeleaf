//
//  MemoryLeakViewController.swift
//  TreeLeafTechnologies
//
//  Created by Preksha Dahal on 31/12/2023.
//

import UIKit

class MemoryLeakViewController: UIViewController {
    //MARK: - Variables
    var name = "Preksha"
    var email = "dahalpreksha88@gmail.com"

    //MARK: - UI Components
    lazy var lblName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = name
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    lazy var lblEmail: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = email
        label.textAlignment = .center
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    lazy var stackLabels: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.backgroundColor = UIColor(Color.pink)
        stack.layer.cornerRadius = 12
        stack.spacing = 8
        stack.addArrangedSubview(lblName)
        stack.addArrangedSubview(lblEmail)
        return stack
    }()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        memoryleak()
    }
    
    //MARK: - Autolayout of UI Components
    func setupUI() {
        autoLayoutForStackView()
    }
        
        func autoLayoutForStackView() {
            view.addSubview(stackLabels)
            NSLayoutConstraint.activate([
                stackLabels.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                stackLabels.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                stackLabels.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                stackLabels.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
                stackLabels.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08),
            ])
        }
        
        func userInfo() {
            print("Name: \(name) \n Email:\(email)")
        }
        
    
    //MARK: - Memory Leak Implementation
        func memoryleak() {
            userInfo()
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "called"), object: nil, queue: .main) { _ in
                self.userInfo()
            }
        }
    //MARK: - Memory Deallocation
        deinit {
            print("Memory released")
        }
    }
