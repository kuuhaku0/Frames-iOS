//
//  CollectionImage.swift
//  Domain
//
//  Created by Tyler Zhao on 11/22/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import Foundation

public struct CollectionImage: Codable {
    public let uid: String
    public let description: String
    public let date: String
    public let comments: [Comment]
}
