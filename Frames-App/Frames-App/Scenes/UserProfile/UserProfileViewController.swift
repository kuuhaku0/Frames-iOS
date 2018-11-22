//
//  UserProfileViewController.swift
//  Frames-App
//
//  Created by Tyler Zhao on 11/20/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    var viewModel: UserProfileViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func bindViewModel() {
        assert(viewModel != nil)
        
        let input = UserProfileViewModel.Input()
        let output = UserProfileViewModel.Output()
        
    }
}
