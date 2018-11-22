//
//  FramesCollection.swift
//  Domain
//
//  Created by Tyler Zhao on 11/22/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import Foundation

public enum CollectionType: String, CodingKey {
    case progressive = "PROGRESSIVE"
    case standard = "STANDARD"
}

public struct FramesCollection {
    public let uid: String
    public let userId: String
    public let numberOfImages: Int
    public let isPrivate: Bool
    public let collectionType: CollectionType
    public let creationDate: String
    public let description: String
    public let tags: [String]
    public let likedBy: [String]
    public let numberOfViews: Int
}
