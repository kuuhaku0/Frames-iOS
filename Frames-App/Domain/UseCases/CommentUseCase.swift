//
//  CommentUseCase.swift
//  Domain
//
//  Created by Tyler Zhao on 11/22/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import Foundation
import RxSwift

public protocol CommentUseCase {
    func comments() -> Observable<[Comment]>
    func create(comment: Comment) -> Observable<Comment>
    func delete(comment: Comment) -> Observable<Void>
    func likeComment(comment: Comment) -> Observable<Void>
    func unlikeComment(comment: Comment) -> Observable<Void>
}
