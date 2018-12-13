//
//  Application.swift
//  Frames-App
//
//  Created by Tyler Zhao on 11/20/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import Foundation
import Domain
import NetworkPlatform

final class Application {
    static let shared = Application()
    
    private let networkUseCaseProvider: Domain.UseCaseProvider
    
    private init() {
        self.networkUseCaseProvider = NetworkPlatform.UseCaseProvider()
    }
    
    func configureMainInterface(in window: UIWindow) {
        let storyboard = UIStoryboard(name: "InitialLaunchScreen", bundle: nil)
        let initialScreenNavController = UINavigationController()
        let initialScreenRouter = InitialLaunchScreenRouter(navigationController: initialScreenNavController,
                                                            storyBoard: storyboard)

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            
        ]
        
        window.rootViewController = initialScreenNavController
        initialScreenRouter.toInititalLaunch()
    }
}
