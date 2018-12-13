//
//  InitialLaunchRouter.swift
//  Frames-App
//
//  Created by Tyler Zhao on 12/12/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit
import Domain

protocol InitialLaunchRouter {
    func toSignUp()
    func toLogin()
}

class InitialLaunchScreenRouter: InitialLaunchRouter {
    
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController,
         storyBoard: UIStoryboard) {
        self.storyBoard = storyBoard
        self.navigationController = navigationController
    }
    
    func toInititalLaunch() {
        let vc = storyBoard.instantiateViewController(ofType: InitialLaunchViewController.self)
        vc.viewModel = InitialLaunchViewModel(router: self)
        navigationController.isNavigationBarHidden = true
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toSignUp() {
        let vc = storyBoard.instantiateViewController(ofType: SignUpViewController.self)
        vc.viewModel = SignUpViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toLogin() {
        let vc = storyBoard.instantiateViewController(ofType: LoginViewController.self)
        vc.viewModel = LoginViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
}
