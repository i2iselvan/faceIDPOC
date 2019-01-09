//
//  OnboardingViewController.swift
//  FaceIDPOC
//
//  Created by Rajaselvan Thangaraj on 09/01/19.
//  Copyright © 2019 Rajaselvan Thangaraj. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.signInButton.layer.cornerRadius = 25.0
        self.signUpButton.layer.cornerRadius = 25.0
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
}
