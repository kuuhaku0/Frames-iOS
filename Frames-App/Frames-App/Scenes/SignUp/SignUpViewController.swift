//
//  SignUpViewController.swift
//  Frames-App
//
//  Created by Tyler Zhao on 12/4/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    var viewModel: SignUpViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func bindViewModel() {
        assert(viewModel != nil)
        
        let input = UserProfileViewModel.Input()
        let output = UserProfileViewModel.Output()
        
    }

}
