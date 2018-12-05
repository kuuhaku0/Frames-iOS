//
//  Scene.swift
//  Frames-App
//
//  Created by Tyler Zhao on 12/4/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import Foundation

protocol TargetScene {
    var transition: SceneTransitionType { get }
}

enum Scene {
    case login
    case signUp
    case mainFeed(MainFeedViewModel)
    case discoverPage(DiscoverPageViewModel)
    case studio(StudioViewModel)
    case userProfile(UserProfileViewModel)
    case activity([Any])
    case alert
}

// TODO: - SWITCH SCENE AND RETURN TRANSITION

//extension Scene: TargetScene {
//    var transition: SceneTransitionType {
//
//    }
//}
