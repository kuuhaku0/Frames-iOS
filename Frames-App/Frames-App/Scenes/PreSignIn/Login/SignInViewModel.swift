//
//  LoginViewModel.swift
//  Frames-App
//
//  Created by Tyler Zhao on 12/5/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import Foundation
import RxSwift

class SignInViewModel: ViewModelType {
    
    struct Input {
        let signInTrigger: Observable<Void>
    }
    
    struct Output {
        
    }
    
    let didTapSignIn = PublishSubject<Void>()
    
    let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        input.signInTrigger
            .bind(to: didTapSignIn)
            .disposed(by: disposeBag)
        
        return Output()
    }
    
}
