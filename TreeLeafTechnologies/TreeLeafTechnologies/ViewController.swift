//
//  ViewController.swift
//  TreeLeafTechnologies
//
//  Created by Preksha Dahal on 29/12/2023.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(Color.pink)
        navigationController?.navigationBar.isHidden = false
        setUpLayouts()
    }
    
    //MARK: - Initialization
    
    
    func createButton(title: String, height: CGFloat, width: CGFloat, target: Any, action: Selector) -> UIButton {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor(Color.black), for: .normal)
        btn.backgroundColor = UIColor(Color.white)
        btn.layer.cornerRadius = 12
        btn.addShadow()
        NSLayoutConstraint.activate([
            btn.heightAnchor.constraint(equalToConstant: height),
            btn.widthAnchor.constraint(equalToConstant: width)
        ])
        btn.addTarget(self, action: action, for: .touchUpInside)
        return btn
    }
    
    lazy var btnTask1: UIButton = createButton(title: "Task 1", height: 60, width: 120, target: self, action: #selector(btnTask1Selected))
    lazy var btnTask2: UIButton = createButton(title: "Task 2", height: 60, width: 120, target: self, action: #selector(btnTask2Selected))
    lazy var btnTask3: UIButton = createButton(title: "Task 3", height: 60, width: 120, target: self, action: #selector(btnTask3Selected))
    lazy var btnTask4: UIButton = createButton(title: "Task 4", height: 60, width: 120, target: self, action: #selector(btnTask4Selected))
    lazy var btnTask5: UIButton = createButton(title: "Task 5", height: 60, width: 120, target: self, action: #selector(btnTask5Selected))
    
    lazy var stackButtons: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.axis = .vertical
        stack.spacing = 12
        stack.addArrangedSubview(btnTask1)
        stack.addArrangedSubview(btnTask2)
        stack.addArrangedSubview(btnTask3)
        stack.addArrangedSubview(btnTask4)
        stack.addArrangedSubview(btnTask5)
        return stack
    }()
    
    //MARK: - Autolayouts
    func setUpLayouts() {
        autoLayoutForStackView()
    }
    
    
    func autoLayoutForStackView() {
        view.addSubview(stackButtons)
        NSLayoutConstraint.activate([
            stackButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackButtons.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackButtons.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            stackButtons.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            stackButtons.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    
    //MARK: - Functions
    
    @objc func btnTask1Selected() {
        print("Umm")
//        let newVC = T1ViewController()
//        navigationController?.popViewController(animated: true)
    }

    
    @objc func btnTask2Selected() {
        print("Task 2 completed")
    }
    
    @objc func btnTask3Selected() {
        print("Task 3 completed")
        
        let newVC = MemoryLeakViewController()
        navigationController?.pushViewController(newVC, animated: true)
    }
    
    @objc func btnTask4Selected() {
        print("Task 4")
    }
    
    @objc func btnTask5Selected() {
        print("Task 5")
    }
}

extension UIView {
    func addShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 2, height: 2) // Adjust these values as needed
        layer.shadowRadius = 4
    }
}
