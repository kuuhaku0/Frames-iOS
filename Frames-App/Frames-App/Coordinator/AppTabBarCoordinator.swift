//
//  AppTabBarCoordinator.swift
//  Frames-App
//
//  Created by Tyler Zhao on 12/31/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import Foundation
import RxSwift

class AppTabBarCoordinator: BaseCoordinator<Void> {
    
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
  
    override func start() -> Observable<Void> {
        let tabBar = UITabBarController()
        
        let mainFeedVC = MainFeedViewController.initFromStoryboard(name: "MainFeedViewController")
        let mainFeedVM = MainFeedViewModel()
        mainFeedVC.viewModel = mainFeedVM
        mainFeedVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 0)
        
        tabBar.viewControllers = [mainFeedVC]
        
        window.rootViewController = tabBar
        window.makeKeyAndVisible()
        
        return Observable.never()
    }
}
