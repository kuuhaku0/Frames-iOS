//
//  UserProfile.swift
//  Domain
//
//  Created by Tyler Zhao on 11/21/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import Foundation

public struct UserProfile: Codable {
    
    public let uid: String
    public let username: String
    public let name: String
    public let followers: [User]
    public let following: [User]
    public let bio: String
    public let profileImage: CollectionImage
    
}
