//
//  LoginViewController.swift
//  Frames-App
//
//  Created by Tyler Zhao on 12/5/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SignInViewController: UIViewController, StoryboardInitializable {
    
    var viewModel: SignInViewModel!
    let disposeBag = DisposeBag()

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
