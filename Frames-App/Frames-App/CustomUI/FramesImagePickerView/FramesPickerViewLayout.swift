//
//  FramesPickerViewLayout.swift
//  Frames-App
//
//  Created by Tyler Zhao on 12/7/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit

public class FramesPickerViewLayout: UICollectionViewFlowLayout {
    
    var width: CGFloat!
    var midX: CGFloat!
    
    override init() {
        super.init()
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
        sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        scrollDirection = .horizontal
        minimumLineSpacing = 0
    }
    
    override public func prepare() {
        let visibleRect = CGRect(origin: self.collectionView!.contentOffset, size: collectionView!.bounds.size)
        midX = visibleRect.midX
        width = visibleRect.width / 2
    }
    
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
