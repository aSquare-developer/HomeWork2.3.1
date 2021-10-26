//
//  WelcomeViewController.swift
//  HomeWork2.3.1
//
//  Created by Artur Anissimov on 26.10.2021.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    
    @IBOutlet var welcomeLabel: UILabel!
    
    var welcome: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        welcomeLabel.text = "Welcome \(welcome ?? "")!"
        
        
    }
}
