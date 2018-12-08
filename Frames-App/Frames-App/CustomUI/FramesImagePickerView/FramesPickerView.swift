//
//  FramesPickerView.swift
//  Frames-App
//
//  Created by Tyler Zhao on 12/7/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit

public protocol FramesPickerViewDelegate: AnyObject {
    func framesPickerView(_ pickerView: FramesPickerView, didSelectItem item: Int)
    func framesPickerView(_ pickerView: FramesPickerView, sizeForItem: Int) -> CGSize
}

public protocol FramesPickerViewDataSource: AnyObject {
    func framesPickerView(_ pickerView: FramesPickerView, numberOfItems item: Int) -> Int
    func framesPickerView(_ pickerView: FramesPickerView, cellForItem item: Int) -> UIImage
}

public class FramesPickerView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    public lazy var selector: UIView = {
        let view = UIView(frame: CGRect(x: collectionView.center.x, y: 0, width: 3, height: bounds.height))
        view.backgroundColor = UIColor.darkGray
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
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
    private func configure() {
        addSubview(collectionView)
        addSubview(selector)
    }
    
    // Returns the center item index in collectionView
    private func findCenterIndex() -> IndexPath? {
        let center = convert(collectionView.center, to: collectionView)
        let index = collectionView.indexPathForItem(at: center)
        return index
    }
    
    // MARK: - Delegate & DataSource Methods
    private func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let selectedItem = findCenterIndex()?.row else { return }
        delegate?.framesPickerView(self, didSelectItem: selectedItem)
    }
    
    private func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let index = findCenterIndex() else { return }
        collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }
    
    // MARK: - Data Source
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.framesPickerView(self, numberOfItems: section) ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(FramesPickerViewCell.self), for: indexPath) as! FramesPickerViewCell
        cell.imageView.image = dataSource?.framesPickerView(self, cellForItem: indexPath.item)
        return cell
    }
    
    // MARK: - Delegate Methods
    private func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    // MARK: - collectionView Layout Methods
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = delegate?.framesPickerView(self, sizeForItem: indexPath.item)
        return size ?? CGSize(width: 0, height: 0)
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
        return UIEdgeInsets(top: 0,
                            left: (collectionView.bounds.size.width - firstSize.width) / 2,
                            bottom: 0,
                            right: (collectionView.bounds.size.width - lastSize.width) / 2)
    }
    
}
