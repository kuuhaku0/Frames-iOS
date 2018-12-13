//
//  InitialLaunchUseCase.swift
//  Domain
//
//  Created by Tyler Zhao on 12/12/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import Foundation
import RxSwift

public protocol InitialLaunchUseCase {
    func toSignUp() -> Observable<Void>
    func toLogin() -> Observable<Void>
}
