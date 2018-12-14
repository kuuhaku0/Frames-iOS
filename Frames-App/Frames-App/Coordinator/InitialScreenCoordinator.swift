//
//  InitialScreenCoordinator.swift
//  Frames-App
//
//  Created by Tyler Zhao on 12/13/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit
import RxSwift

class InitialScreenCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let viewModel = InitialLaunchViewModel()
        let vc = InitialLaunchViewController.initFromStoryboard(name: InitialLaunchViewController.storyboardIdentifier)
        let navigationController = UINavigationController(rootViewController: vc)
        vc.viewModel = viewModel
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    
        return Observable.never()
    }
    
}
