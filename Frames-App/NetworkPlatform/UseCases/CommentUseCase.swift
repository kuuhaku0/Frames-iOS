//
//  CommentUseCase.swift
//  NetworkPlatform
//
//  Created by Tyler Zhao on 11/22/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import Foundation
import RxSwift
import Domain

final class CommentUseCase<Cache>: Domain.CommentUseCase where Cache: AbstractCache, Cache.T == Comment {
    
    private let network: CommentNetwork
    private let cache: Cache
    
    init(network: CommentNetwork, cache: Cache) {
        self.network = network
        self.cache = cache
    }
    
    func comments() -> Observable<[Comment]> {
        let fetchPosts = cache.fetchObjects().asObservable()
        let stored = network.fetchComments()
            .flatMap {
                return self.cache.save(objects: $0)
                    .asObservable()
                    .map(to: [Comment].self)
                    .concat(Observable.just($0))
        }
        return fetchPosts.concat(stored)
    }
    
    func create(comment: Comment) -> Observable<Comment> {
        return network.createComment()
    }
    
    func delete(comment: Comment) -> Observable<Void> {
        return network.deleteComment(path: comment.userId, itemId: comment.uid)
            .map({_ in})
    }
    
    func likeComment(comment: Comment) -> Observable<Void> {
        return network.likeComment(comment: comment)
            .map({_ in})
    }
    
    func unlikeComment(comment: Comment) -> Observable<Void> {
        return network.unlikeComment(comment: comment)
            .map {_ in}
    }
}

struct MapFromNever: Error {}
extension ObservableType where E == Never {
    func map<T>(to: T.Type) -> Observable<T> {
        return self.flatMap { _ in
            return Observable<T>.error(MapFromNever())
        }
    }
}
