//
//  Comment+Mapping.swift
//  NetworkPlatform
//
//  Created by Tyler Zhao on 11/22/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import Foundation
import Domain
import RxSwift

extension Comment: Identifiable {}

extension Comment {
    func toJSON() -> [String: Any] {
        return [:
        ]
    }
}

extension Comment: Encodable {
    var encoder: NETComment {
        return NETComment(with: self)
    }
}

final class NETComment: NSObject, NSCoding, DomainConvertibleType {
    struct Keys {
        static let likes = "likes"
        static let text = "text"
        static let uid = "uid"
        static let userId = "userId"
        static let date = "date"
    }
    let userId: String
    let text: String
    let uid: String
    let likes: String
    let date: String
    
    init(with domain: Comment) {
        self.likes = domain.likes
        self.text = domain.text
        self.uid = domain.uid
        self.userId = domain.userId
        self.date = domain.date
    }
    
    init?(coder aDecoder: NSCoder) {
        guard
            let likes = aDecoder.decodeObject(forKey: Keys.likes) as? String,
            let text = aDecoder.decodeObject(forKey: Keys.text) as? String,
            let uid = aDecoder.decodeObject(forKey: Keys.uid) as? String,
            let userId = aDecoder.decodeObject(forKey: Keys.userId) as? String,
            let date = aDecoder.decodeObject(forKey: Keys.date) as? String
            else {
                return nil
        }
        self.likes = likes
        self.text = text
        self.uid = uid
        self.userId = userId
        self.date = date
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: Keys.text)
        aCoder.encode(likes, forKey: Keys.likes)
        aCoder.encode(uid, forKey: Keys.uid)
        aCoder.encode(userId, forKey: Keys.userId)
        aCoder.encode(date, forKey: Keys.date)
    }
    
    func asDomain() -> Comment {
        return Comment(uid: uid,
                       userId: userId,
                       text: text,
                       date: date,
                       likes: likes)
    }
}
