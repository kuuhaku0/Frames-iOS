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
    private var rootCoordinator: BaseCoordinator<Void>?
    
    init(window: UIWindow) {
        self.window = window
        self.networkUseCaseProvider = NetworkPlatform.UseCaseProvider()
    }
    
    override func start() -> Observable<Void> {
        // Manually calling start because coordinate(to: ) is not delloc coordinator tied to window
        self.rootCoordinator = PreLoginFlowCoordinator(window: self.window)
        self.rootCoordinator?.start()
            .subscribe(onNext: {
                self.rootCoordinator = nil
            })
            .disposed(by: disposeBag)
        return Observable.never()
    }
    
}
