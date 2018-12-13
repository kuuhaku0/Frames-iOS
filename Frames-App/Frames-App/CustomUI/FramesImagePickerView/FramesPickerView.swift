//
//  FramesPickerView.swift
//  Frames-App
//
//  Created by Tyler Zhao on 12/7/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

@objc
protocol FramesPickerViewDelegate: AnyObject {
    @objc optional func framesPickerView(_ pickerView: FramesPickerView, didSelectItem item: Int)
    @objc optional func framesPickerView(_ pickerView: FramesPickerView, sizeForItem: Int) -> CGSize
}

protocol FramesPickerViewDataSource: AnyObject {
    func framesPickerView(_ pickerView: FramesPickerView, numberOfItems item: Int) -> Int
    func framesPickerView(_ pickerView: FramesPickerView, cellForItem item: Int) -> UIImage
}

@IBDesignable
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
        cv.bounces = false
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
    
    private func findCenterIndex() -> IndexPath? {
        let center = convert(collectionView.center, to: collectionView)
        let index = collectionView.indexPathForItem(at: center)
        return index
    }
    
    public func scrollToLastItem() {
        let speed: CGFloat = 8
        let co = collectionView.contentOffset.x
        let no = co + speed
        let cellWidth: CGFloat = 50
        UIView.animate(withDuration: 0.0015, delay: 0, options: .curveEaseIn, animations: { [weak self] in
            self?.collectionView.contentOffset = CGPoint(x: no, y: 0)
            }, completion: { [weak self] (complete) in
                guard let self = self else { return }
                // This expression isnt 100% 
                if co >= self.collectionView.contentSize.width / 2 - cellWidth - speed * 2.5 { return }
                self.scrollToLastItem()
        })
    }
    
    // MARK: - Delegate & DataSource Methods
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let selectedItem = findCenterIndex()?.row else { return }
        // TODO: - MAKE THIS SAFER
        delegate?.framesPickerView!(self, didSelectItem: selectedItem)
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

extension FramesPickerView {
    public typealias Delegate = FramesPickerViewDelegate
    public typealias DataSource = FramesPickerViewDataSource
}

class FramesPickerViewDelegateProxy: DelegateProxy<FramesPickerView, FramesPickerViewDelegate>, DelegateProxyType, FramesPickerViewDelegate {
    
    static func currentDelegate(for object: FramesPickerView) -> FramesPickerViewDelegate? {
        return object.delegate
    }
    
    static func setCurrentDelegate(_ delegate: FramesPickerViewDelegate?, to object: FramesPickerView) {
        object.delegate = delegate
    }
    
    init(parentObject: FramesPickerView) {
        super.init(parentObject: parentObject, delegateProxy: FramesPickerViewDelegateProxy.self)
    }
    
    public static func registerKnownImplementations() {
        self.register { FramesPickerViewDelegateProxy(parentObject: $0) }
    }
    
}


//fileprivate let framesPickerViewDataSourceNotSet = FramesPickerViewDataSourceNotSet()
//
//fileprivate final class FramesPickerViewDataSourceNotSet: NSObject, FramesPickerViewDataSource {
//    func framesPickerView(_ pickerView: FramesPickerView, numberOfItems item: Int) -> Int {
//        return 0
//    }
//
//    func framesPickerView(_ pickerView: FramesPickerView, cellForItem item: Int) -> UIImage {
//        return UIImage()
//    }
//
//}
//
//class FramesPickerViewDataSourceProxy: DelegateProxy<FramesPickerView, FramesPickerViewDataSource>, DelegateProxyType, FramesPickerViewDataSource {
//
//    public weak private(set) var framesPickerView: FramesPickerView?
//
//    private weak var _requiredMethodsDataSource: FramesPickerViewDataSource? = framesPickerViewDataSourceNotSet
//
//    public init(framesPickerView: ParentObject) {
//        self.framesPickerView = framesPickerView
//        super.init(parentObject: framesPickerView, delegateProxy: FramesPickerViewDataSourceProxy.self)
//    }
//
//    public static func registerKnownImplementations() {
//        self.register { FramesPickerViewDataSourceProxy(framesPickerView: $0) }
//    }
//
//    public static func currentDelegate(for object: FramesPickerView) -> FramesPickerViewDataSource? {
//        return object.dataSource
//    }
//
//    public static func setCurrentDelegate(_ delegate: FramesPickerViewDataSource?, to object: FramesPickerView) {
//        object.dataSource = delegate
//    }
//
//    func framesPickerView(_ pickerView: FramesPickerView, numberOfItems item: Int) -> Int {
//        return _requiredMethodsDataSource?.framesPickerView(_:numberOfItems:)
//    }
//
//    func framesPickerView(_ pickerView: FramesPickerView, cellForItem item: Int) -> UIImage {
//        return (_requiredMethodsDataSource ?? framesPickerViewDataSourceNotSet).framesPickerView(pickerView, numberOfItems: item)
//    }
//
//}


extension Reactive where Base: FramesPickerView {
    var delegate: DelegateProxy<FramesPickerView, FramesPickerViewDelegate> {
        return FramesPickerViewDelegateProxy.proxy(for: base)
    }
    
    var didSelectItem: Observable<Int> {
        return delegate
            .methodInvoked(#selector(FramesPickerViewDelegate.framesPickerView(_:didSelectItem:)))
            .map { params in
                return (params[1] as! Int)
        }
    }
    
    var sizeForItem: Observable<CGSize> {
        return delegate
            .methodInvoked(#selector(FramesPickerViewDelegate.framesPickerView(_:sizeForItem:)))
            .map { params -> CGSize in
                return params[1] as! CGSize
            }
    }
}

//extension Reactive where Base: FramesPickerView {
//    var dataSource: DelegateProxy<FramesPickerView, FramesPickerViewDataSource> {
//        return FramesPickerViewDataSourceProxy.proxy(for: base)
//    }
//
//
//}
