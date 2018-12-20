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

    struct Input {
        let signUpTigger: Driver<Void>
        let signInTrigger: Driver<Void>
    }
    
    struct Output {
        let signUp: Driver<Void>
        let signIn: Driver<Void>
        let images$: Driver<[UIImage]>
    }
    
    func transform(input: Input) -> Output {
        
        let images: Driver<[UIImage]> = Driver.just([UIImage(imageLiteralResourceName: "Logo"),
                                                     UIImage(imageLiteralResourceName: "Logo2"),
                                                     UIImage(imageLiteralResourceName: "Logo3"),
                                                     UIImage(imageLiteralResourceName: "Logo4"),
                                                     UIImage(imageLiteralResourceName: "Logo5"),
                                                     UIImage(imageLiteralResourceName: "Logo6"),
                                                     UIImage(imageLiteralResourceName: "Logo7")])
        
        let signUp = input
            .signUpTigger
            .do(onNext: {
                
            })
        
        let signIn = input
            .signInTrigger
            .do(onNext: {
               
            })
        
        return Output(signUp: signUp,
                      signIn: signIn,
                      images$: images)
    }
    
}