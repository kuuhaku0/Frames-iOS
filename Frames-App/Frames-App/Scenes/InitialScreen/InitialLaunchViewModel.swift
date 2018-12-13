//
//  InitialLaunchViewModel.swift
//  Frames-App
//
//  Created by Tyler Zhao on 12/5/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

final class InitialLaunchViewModel: ViewModelType {
    
    let images: [UIImage] = [UIImage(imageLiteralResourceName: "Logo"),
                             UIImage(imageLiteralResourceName: "Logo2"),
                             UIImage(imageLiteralResourceName: "Logo3"),
                             UIImage(imageLiteralResourceName: "Logo4"),
                             UIImage(imageLiteralResourceName: "Logo5"),
                             UIImage(imageLiteralResourceName: "Logo6"),
                             UIImage(imageLiteralResourceName: "Logo7")]
    
    struct Input {
        let signUpTigger: Driver<Void>
        let signInTrigger: Driver<Void>
    }
    
    struct Output {
        let signUp: Driver<Void>
        let signIn: Driver<Void>
    }
    
    private let router: InitialLaunchRouter
    
    init(router: InitialLaunchRouter) {
        self.router = router
    }
    
    func transform(input: Input) -> Output {
        let signUp = input
            .signUpTigger
            .do(onNext: {
                self.router.toSignUp()
            })
        
        let signIn = input
            .signInTrigger
            .do(onNext: {
                self.router.toLogin()
            })
        
        return Output(signUp: signUp,
                      signIn: signIn)
    }
    
}
