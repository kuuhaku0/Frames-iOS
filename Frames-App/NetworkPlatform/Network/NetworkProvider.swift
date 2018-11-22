//
//  NetworkProvider.swift
//  NetworkPlatform
//
//  Created by Tyler Zhao on 11/20/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import Foundation
import Domain

final class NetworkProvider {
    private let apiEndpoint: String
    
    public init() {
        apiEndpoint = ""
    }
    
    public func makeCommentsNetwork() -> CommentNetwork {
        let network = Network<Comment>(apiEndpoint)
        return CommentNetwork(network: network)
    }
    
}
