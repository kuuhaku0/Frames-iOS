//
//  SignUpViewModel.swift
//  Frames-App
//
//  Created by Tyler Zhao on 12/4/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct FramesFormCellModel {
    let title: String
    let description: String
    let placeholder: String
}

final class SignUpViewModel: ViewModelType {

    let disposeBag = DisposeBag()
    
    struct Input {
        
    }
    
    struct Output {
        var formCellDataSource: Driver<[FramesFormCellModel]>
    }
    
    func transform(input: Input) -> Output {
        let formCellDataSource$ = Driver.just([FramesFormCellModel(title: "Email",
                                                                      description: "",
                                                                      placeholder: "enter your email..."),
                                                  
                                                  FramesFormCellModel(title: "Username",
                                                                      description: "can contain letters, numbers, underscores and dashes",
                                                                      placeholder: "create a username..."),
                                                  
                                                  FramesFormCellModel(title: "Password",
                                                                      description: "password must be 8+ characters",
                                                                      placeholder: "choose a password...")])
        
        return Output(formCellDataSource: formCellDataSource$)
    }
}
