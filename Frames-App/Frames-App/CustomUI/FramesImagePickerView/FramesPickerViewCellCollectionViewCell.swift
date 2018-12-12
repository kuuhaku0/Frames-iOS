//
//  FramesPickerViewCellCollectionViewCell.swift
//  Frames-App
//
//  Created by Tyler Zhao on 12/7/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit

public class FramesPickerViewCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: contentView.frame)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var label: UILabel = {
        let lb = UILabel(frame: CGRect(x: center.x, y: center.y, width: 0, height: 0))
        lb.numberOfLines = 0
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
        contentView.addSubview(imageView)
        contentView.addSubview(label)
    }
}
