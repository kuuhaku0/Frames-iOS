//
//  CommentNetwork.swift
//  NetworkPlatform
//
//  Created by Tyler Zhao on 11/22/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import Foundation
import Domain
import RxSwift

public final class CommentNetwork {
    private let network: Network<Comment>
    
    init(network: Network<Comment>) {
        self.network = network
    }
    
    public func createComment() -> Observable<Comment> {
        return network.postItem("", parameters: [:])
    }
    
    public func likeComment(comment: Comment) -> Observable<Comment> {
        return network.updateItem(comment.userId, itemId: comment.uid, parameters: ["likedBy": comment.userId])
    }
    
    public func unlikeComment(comment: Comment) -> Observable<Comment> {
        return network.updateItem(comment.userId, itemId: comment.uid, parameters: ["likedBy": comment.userId])
    }
    
    public func deleteComment(path: String, itemId: String) -> Observable<Comment> {
        return network.deleteItem(path, itemId: itemId)
    }
    
    public func fetchComments() -> Observable<[Comment]> {
        return network.getItems("comments")
    }
    
    public func fetchComment(commentId: String) -> Observable<Comment> {
        return network.getItem("comments", itemId: commentId)
    }
    
    
}
