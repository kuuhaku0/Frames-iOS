//
//  Constants.swift
//  Frames-App
//
//  Created by Tyler Zhao on 12/4/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit

struct HEX {
    static let _333333 = "333333"
    static let _666666 = "666666"
    static let _999999 = "999999"
    static let DDDDDD = "DDDDDD"
    static let EEEEEE = "EEEEEE"
}

struct Constants {
    static let photosPerCollection: Int = 10

    static let buttonCornerRadius: Double = 3.0
    static let framesButtonHeight: CGFloat = 45
    static let framesButtonBackgroundColor = UIColor(hexString: HEX._333333)
    static let framesButtonTextColor: UIColor = .white
    
    struct Color {
        static let iron = UIColor(red: 94.0/255.0, green: 94.0/255.0, blue: 94.0/255.0, alpha: 1.0)
        static let yellowZ = UIColor(red: 252.0/255.0, green: 197.0/255.0, blue: 6.0/255.0, alpha: 1.0)
    }
    
    struct Fonts {
        static let buttonFont: UIFont = UIFont.boldSystemFont(ofSize: 16)
    }
}
