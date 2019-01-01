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
        
        tabBar.viewControllers = [createMainFeedVC(),
                                  createDiscoveryPageVC(),
                                  createStudioVC(),
                                  createUserProfileVC()]
        
        window.rootViewController = tabBar
        window.makeKeyAndVisible()
        
        return Observable.never()
    }
    
    private func createMainFeedVC() -> UIViewController {
        let nav = UINavigationController()
        
        nav.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        coordinate(to: MainFeedCoordinator(rootNavigationController: nav))
            .subscribe()
            .disposed(by: disposeBag)
        
        return nav
    }
    
    private func createDiscoveryPageVC() -> UIViewController {
        let nav = UINavigationController()
        
        nav.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        coordinate(to: DiscoverPageCoordinator(rootNavigationController: nav))
            .subscribe()
            .disposed(by: disposeBag)
        
        return nav
    }
    
    private func createStudioVC() -> UIViewController {
        let nav = UINavigationController()
        
        nav.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 2)
        coordinate(to: StudioCoordinator(rootNavigationController: nav))
            .subscribe()
            .disposed(by: disposeBag)
        
        return nav
    }
    
    private func createUserProfileVC() -> UIViewController {
        let nav = UINavigationController()

        nav.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 3)
        coordinate(to: UserProfileCoordinator(rootNavigationController: nav))
            .subscribe()
            .disposed(by: disposeBag)
        
        return nav
    }
}
