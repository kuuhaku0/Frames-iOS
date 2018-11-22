//
//  Encodable.swift
//  NetworkPlatform
//
//  Created by Tyler Zhao on 11/20/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

protocol DomainConvertibleType {
    associatedtype DomainType: Identifiable
    
    init(with domain: DomainType)
    
    func asDomain() -> DomainType
}

protocol Identifiable {
    var uid: String { get }
}

typealias DomainConvertibleCoding = DomainConvertibleType

protocol Encodable {
    associatedtype Encoder: DomainConvertibleCoding
    
    var encoder: Encoder { get }
}

