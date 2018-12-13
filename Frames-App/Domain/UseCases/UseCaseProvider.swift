//
//  UseCaseProvider.swift
//  Frames-App
//
//  Created by Tyler Zhao on 11/19/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import Foundation

public protocol UseCaseProvider {
    func makeCommentUseCase() -> CommentUseCase
   // func makeInitialLaunchUseCase() -> InitialLaunchUseCase
}
