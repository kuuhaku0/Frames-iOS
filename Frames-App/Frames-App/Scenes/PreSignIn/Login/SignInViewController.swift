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
    
    @IBOutlet weak var loginTextField: FramesTextField!
    @IBOutlet weak var passwordTextField: FramesTextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var signInButton: FramesButton!
    
    var viewModel: SignInViewModel!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindViewModel()
    }
    
    private func setup() {
        title = "Sign In"
    }
    
    private func bindViewModel() {
        assert(viewModel != nil)
        
        let input = SignInViewModel.Input(signInTrigger: signInButton.rx.tap.asObservable())
        
        let output = viewModel.transform(input: input)
    }
}
