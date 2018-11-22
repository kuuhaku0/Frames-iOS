//
//  CollectionsUseCase.swift
//  Domain
//
//  Created by Tyler Zhao on 11/21/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import Foundation
import RxSwift

protocol FramesCollectionUseCase {
    func collection() -> Observable<[FramesCollection]>
    func save(collection: FramesCollection) -> Observable<Void>
    func delete(collection: FramesCollection) -> Observable<Void>
    func editTags(collection: FramesCollection, tags: [String]) -> Observable<Void>
}
