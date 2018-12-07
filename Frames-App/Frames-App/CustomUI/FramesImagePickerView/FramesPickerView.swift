//
//  FramesPickerView.swift
//  Frames-App
//
//  Created by Tyler Zhao on 12/7/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit

protocol FramesPickerViewDelegate: AnyObject {
    func framesPickerView(_ pickerView: FramesPickerView, didSelectItem item: Int)
}

protocol FramesPickerViewDataSource: AnyObject {
    func framesPickerView(_ pickerView: FramesPickerView, numberOfItems item: Int) -> Int
    func framesPickerView(_ pickerView: FramesPickerView, cellForItem item: Int) -> UIImage
}

class FramesPickerViewCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: contentView.frame)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
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
    }
}

class FramesPickerViewLayout: UICollectionViewFlowLayout {
    
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
    
    override func prepare() {
        let visibleRect = CGRect(origin: self.collectionView!.contentOffset, size: collectionView!.bounds.size)
        midX = visibleRect.midX
        width = visibleRect.width / 2
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}

class FramesPickerView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    lazy var selector: UIView = {
        let view = UIView(frame: CGRect(x: collectionView.center.x, y: 0, width: 3, height: bounds.height))
        view.backgroundColor = UIColor.darkGray
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = FramesPickerViewLayout()
        let cv = UICollectionView(frame: bounds, collectionViewLayout: layout)
        cv.register(FramesPickerViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(FramesPickerViewCell.self))
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    public weak var delegate: FramesPickerViewDelegate?
    public weak var dataSource: FramesPickerViewDataSource?
    
    public var contentOffset: CGPoint {
        get {
            return self.collectionView.contentOffset
        }
    }
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    // MARK: -
    func configure() {
        addSubview(collectionView)
        addSubview(selector)
    }
    
    func findCenterIndex() -> IndexPath? {
        let center = convert(collectionView.center, to: collectionView)
        let index = collectionView.indexPathForItem(at: center)
        return index
    }
    
    // MARK: - Delegate & DataSource Methods
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let selectedItem = findCenterIndex()?.row else { return }
        delegate?.framesPickerView(self, didSelectItem: selectedItem)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let index = findCenterIndex() else { return }
        collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.framesPickerView(self, numberOfItems: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(FramesPickerViewCell.self), for: indexPath) as! FramesPickerViewCell
        cell.imageView.image = dataSource?.framesPickerView(self, cellForItem: indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 50, height: 50)
        return size
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let number = self.collectionView(collectionView, numberOfItemsInSection: section)
        let firstIndexPath = IndexPath(item: 0, section: section)
        let firstSize = self.collectionView(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAt: firstIndexPath)
        let lastIndexPath = IndexPath(item: number - 1, section: section)
        let lastSize = self.collectionView(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAt: lastIndexPath)
        return UIEdgeInsets(
            top: 0, left: (collectionView.bounds.size.width - firstSize.width) / 2,
            bottom: 0, right: (collectionView.bounds.size.width - lastSize.width) / 2
        )
    }
    
}