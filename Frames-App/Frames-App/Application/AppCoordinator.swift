//
//  Application.swift
//  Frames-App
//
//  Created by Tyler Zhao on 11/20/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import Foundation
import RxSwift
import Domain
import NetworkPlatform

class AppCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    private let networkUseCaseProvider: Domain.UseCaseProvider
    
    init(window: UIWindow) {
        self.window = window
        self.networkUseCaseProvider = NetworkPlatform.UseCaseProvider()
    }
    
    override func start() -> Observable<Void> {
        let inititalScreenCoordinator = InitialScreenCoordinator(window: window)
        return coordinate(to: inititalScreenCoordinator)
    }
    
}
