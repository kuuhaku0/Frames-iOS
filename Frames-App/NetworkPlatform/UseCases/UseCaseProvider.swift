//
//  UseCaseProvider.swift
//  NetworkPlatform
//
//  Created by Tyler Zhao on 11/20/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import Foundation
import Domain

public final class UseCaseProvider: Domain.UseCaseProvider {
    
    private let networkProvider: NetworkProvider
    
    public init() {
        networkProvider = NetworkProvider()
    }
    
    public func makeCommentUseCase() -> Domain.CommentUseCase {
        return CommentUseCase(network: networkProvider.makeCommentsNetwork(),
                            cache: Cache<Comment>(path: "allComments"))
    }

}
