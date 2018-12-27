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
        let signUpTigger: Observable<Void>
        let signInTrigger: Observable<Void>
    }
    
    struct Output {
        let images$: Driver<[UIImage]>
    }
    
    let didTapSignIn = PublishSubject<Void>()
    let didTapSignUp = PublishSubject<Void>()
    
    let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        let images: Driver<[UIImage]> = Driver.just([UIImage(imageLiteralResourceName: "Logo7"),
                                                     UIImage(imageLiteralResourceName: "Logo6"),
                                                     UIImage(imageLiteralResourceName: "Logo5"),
                                                     UIImage(imageLiteralResourceName: "Logo4"),
                                                     UIImage(imageLiteralResourceName: "Logo3"),
                                                     UIImage(imageLiteralResourceName: "Logo2"),
                                                     UIImage(imageLiteralResourceName: "Logo")])
        
        input.signInTrigger
            .bind(to: didTapSignIn)
            .disposed(by: disposeBag)
        
        input.signUpTigger
            .bind(to: didTapSignUp)
            .disposed(by: disposeBag)
        
        return Output(images$: images)
    }
    
}
