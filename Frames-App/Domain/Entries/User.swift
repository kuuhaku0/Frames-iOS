//
//  User.swift
//  Domain
//
//  Created by Tyler Zhao on 11/21/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import Foundation

public struct User: Codable {
    
    public let uid: String
    public let email: String
    public let password: String
    public let username: String
    public let userProfile: UserProfile
}
