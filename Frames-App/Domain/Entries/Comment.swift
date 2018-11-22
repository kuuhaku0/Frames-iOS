//
//  Comment.swift
//  Domain
//
//  Created by Tyler Zhao on 11/22/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import Foundation

public struct Comment: Codable {
    public let uid: String
    public let userId: String
    public let text: String
    public let date: String
    public let likes: String
    
    public init(uid: String,
                userId: String,
                text: String,
                date: String,
                likes: String) {
        
        self.uid = uid
        self.userId = userId
        self.text = text
        self.date = date
        self.likes = likes
    }
    
    public init(text: String) {
        self.init(uid: NSUUID().uuidString,
                  userId: "testUser", text: text, date: String(round(Date().timeIntervalSince1970 * 1000)), likes: "")
    }
    
    private enum CodingKeys: String, CodingKey {
        case uid
        case userId
        case text
        case date
        case likes
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        text = try container.decode(String.self, forKey: .text)
        
        if let date = try container.decodeIfPresent(Int.self, forKey: .date) {
            self.date = "\(date)"
        } else {
            date = try container.decodeIfPresent(String.self, forKey: .date) ?? ""
        }
        
        if let userId = try container.decodeIfPresent(Int.self, forKey: .userId) {
            self.userId = "\(userId)"
        } else {
            userId = try container.decode(String.self, forKey: .userId)
        }
        
        if let uid = try container.decodeIfPresent(Int.self, forKey: .uid) {
            self.uid = "\(uid)"
        } else {
            uid = try container.decodeIfPresent(String.self, forKey: .uid) ?? ""
        }
        
        if let likes = try container.decodeIfPresent(Int.self, forKey: .likes) {
            self.likes = "\(likes)"
        } else {
            likes = try container.decodeIfPresent(String.self, forKey: .likes) ?? ""
        }
    }
}

extension Comment: Equatable {
    public static func == (lhs: Comment, rhs: Comment) -> Bool {
        return lhs.uid == rhs.uid &&
            lhs.userId == rhs.userId &&
            lhs.text == rhs.text &&
            lhs.date == rhs.date &&
            lhs.likes == rhs.likes
    }
}
