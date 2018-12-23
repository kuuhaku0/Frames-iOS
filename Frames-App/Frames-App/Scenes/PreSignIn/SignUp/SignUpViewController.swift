//
//  SignUpViewController.swift
//  Frames-App
//
//  Created by Tyler Zhao on 12/4/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, StoryboardInitializable {
    
    var viewModel: SignUpViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    private func setup() {
       
    }
    
    private func bindViewModel() {
        assert(viewModel != nil)
        
        let input = UserProfileViewModel.Input()
        let output = UserProfileViewModel.Output()
        
        
    }

}
