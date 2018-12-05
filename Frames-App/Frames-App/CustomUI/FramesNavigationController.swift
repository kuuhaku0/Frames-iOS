//
//  FramesNavigationController.swift
//  Frames-App
//
//  Created by Tyler Zhao on 12/4/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit
import Action
import RxSwift
import NetworkPlatform

class FramesNavigationController: UINavigationController {
    
    private var sceneCoordiantor: SceneCoordinatorType!
    private let disposeBag = DisposeBag()
    
    private lazy var showUserProfile: CocoaAction = {
        let viewModel = UserProfileViewModel()
        return CocoaAction { [unowned self] in
            self.sceneCoordiantor.transition(to: Scene.userProfile(viewModel))
        }
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init(rootViewController: UIViewController,
         sceneCoordiantor: SceneCoordinatorType = SceneCoordinator.shared) {
        super.init(rootViewController: rootViewController)
        self.sceneCoordiantor = sceneCoordiantor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        configureNavigationBar()
    }
    
    // TODO: - Config Nav Bar
    private func configureNavigationBar() {
        
    }
}
