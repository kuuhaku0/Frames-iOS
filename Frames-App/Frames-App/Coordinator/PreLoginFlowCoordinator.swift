//
//  InitialScreenCoordinator.swift
//  Frames-App
//
//  Created by Tyler Zhao on 12/13/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit
import RxSwift

protocol PreLoginFlowCoordinate {
    func showLogin()
    func showSignUp()
}

class PreLoginFlowCoordinator: BaseCoordinator<Void>, PreLoginFlowCoordinate {
    
    private let window: UIWindow
    private var navigationController: UINavigationController?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let viewModel = InitialLaunchViewModel(coordinator: self)
        let vc = InitialLaunchViewController.initFromStoryboard(name: InitialLaunchViewController.storyboardIdentifier)
        self.navigationController = UINavigationController(rootViewController: vc)
        
        vc.viewModel = viewModel
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    
        return Observable.never()
    }
    
    func showLogin() {
        let viewModel = LoginViewModel()
        let vc = LoginViewController.initFromStoryboard(name: LoginViewController.storyboardIdentifier)
        
        vc.viewModel = viewModel
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showSignUp() {
        let viewModel = SignUpViewModel()
        let vc = SignUpViewController.initFromStoryboard(name: SignUpViewController.storyboardIdentifier)
        
        vc.viewModel = viewModel

        self.navigationController?.pushViewController(vc, animated: true)
    }
}
