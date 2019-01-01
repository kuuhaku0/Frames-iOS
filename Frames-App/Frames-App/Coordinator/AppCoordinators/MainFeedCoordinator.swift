//
//  MainFeedCoordinator.swift
//  Frames-App
//
//  Created by Tyler Zhao on 12/31/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit
import RxSwift

class MainFeedCoordinator: BaseCoordinator<Void> {
    
    var rootNavigationController: UINavigationController
    
    init(rootNavigationController: UINavigationController) {
        self.rootNavigationController = rootNavigationController
    }
    
    override func start() -> Observable<Void> {
        
        let vc = MainFeedViewController.initFromStoryboard()
        let vm = MainFeedViewModel()
        
        vc.viewModel = vm
        rootNavigationController.pushViewController(vc, animated: true)
        
        return Observable.never()
    }
}
