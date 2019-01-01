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
        let nav = UINavigationController(rootViewController: tabBar)
        
        tabBar.viewControllers = [createMainFeedVC(),
                                  createDiscoveryPageVC(),
                                  createStudioVC(),
                                  createUserProfileVC()]
        
        window.rootViewController = nav
        window.makeKeyAndVisible()
        
        return Observable.never()
    }
    
    private func createMainFeedVC() -> UIViewController {
        let vc = MainFeedViewController.initFromStoryboard(name: MainFeedViewController.storyboardIdentifier)
        let vm = MainFeedViewModel()
        
        vc.viewModel = vm
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 0)
        
        return vc
    }
    
    private func createDiscoveryPageVC() -> UIViewController {
        let vc = DiscoverPageViewController.initFromStoryboard(name: DiscoverPageViewController.storyboardIdentifier)
        let vm = DiscoverPageViewModel()
        
        vc.viewModel = vm
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        
        return vc
    }
    
    private func createStudioVC() -> UIViewController {
        let vc = StudioViewController.initFromStoryboard(name: StudioViewController.storyboardIdentifier)
        let vm = StudioViewModel()
        
        vc.viewModel = vm
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 2)
        
        return vc
    }
    
    private func createUserProfileVC() -> UIViewController {
        let vc = UserProfileViewController.initFromStoryboard(name: UserProfileViewController.storyboardIdentifier)
        let vm = UserProfileViewModel()
        
        vc.viewModel = vm
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 3)
        
        return vc
    }
}
