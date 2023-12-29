//
//  JokesViewController.swift
//  TreeLeafTechnologies
//
//  Created by Preksha Dahal on 29/12/2023.
//

import UIKit
import Alamofire
import ObjectMapper

class JokesViewController: UIViewController {
    
    // MARK: - Constants and Variables
    
    
    // MARK: - Initialization
    lazy var lblView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(Color.pink)
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(Color.transparent).cgColor
        return view
    }()
    
    lazy var lblJoke: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = UIColor(Color.white)
        label.numberOfLines = 0
        return label
    }()
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        apiCall()
        
    }
}

// MARK: - Autolayout for UICOmponents
extension JokesViewController {
    
    // MARK: - Setting Up Autolayout for UI Components
    func setupLayout() {
        autoLayoutForLabel()
        autoLayoutForView()
    }
    
    // MARK: - Autolayout
    func autoLayoutForView() {
        view.addSubview(lblView)
        NSLayoutConstraint.activate([
            lblView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lblView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            lblView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            lblView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }
    
    func autoLayoutForLabel(){
        lblView.addSubview(lblJoke)
        NSLayoutConstraint.activate([
            lblJoke.topAnchor.constraint(equalTo: lblView.topAnchor, constant: 20),
            lblJoke.bottomAnchor.constraint(equalTo: lblView.bottomAnchor, constant: -20),
            lblJoke.centerXAnchor.constraint(equalTo: lblView.centerXAnchor, constant: 20),
            lblJoke.trailingAnchor.constraint(equalTo: lblView.trailingAnchor, constant: -20),
        ])
    }
}
// MARK: - Actions for UIComponents
extension JokesViewController {
    
    // MARK: - Setup Actions for UIComponents
    func setupUIAction() {
        
    }
}

extension JokesViewController{
    // MARK: - API Call
    func apiCall() {
        getJoke()
    }
    func getJoke() {
        
        struct APIEndpoints {
            static let joke = "https://official-joke-api.appspot.com/random_joke"
        }
        
        AF.request(APIEndpoints.joke).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let jsonData = value as? [String: Any],
                   let jokeResponse = Mapper<Joke>().map(JSON: jsonData) {
                    self.updateJokeUI(with: jokeResponse)
                } else {
                    print("Error mapping JSON to Joke object")
                }
            case .failure(let error):
                print("Joke Error: \(error)")
            }
        }
    }
    
    func updateJokeUI(with jokeResponse: Joke) {
        DispatchQueue.main.async {
            self.lblJoke.text = "\(jokeResponse.setup ?? "")\n\(jokeResponse.punchline ?? "")"
        }
    }
}

