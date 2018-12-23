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
import RxDataSources

@objc
protocol FramesPickerViewDelegate: AnyObject {
    @objc optional func framesPickerView(_ pickerView: FramesPickerView, didSelectItem item: Int)
    @objc optional func framesPickerView(_ pickerView: FramesPickerView, sizeForItem: Int) -> CGSize
}

@IBDesignable
class FramesPickerView: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    weak var delegate: FramesPickerViewDelegate?
    
    // MARK: - Properties
    private lazy var selector: UIView = {
        let view = UIView(frame: CGRect(x: collectionView.center.x, y: 0, width: 3, height: collectionView.bounds.height))
        view.backgroundColor = UIColor.darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = FramesPickerViewLayout()
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.register(FramesPickerViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(FramesPickerViewCell.self))
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.bounces = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    public var contentOffset: CGPoint {
        get {
            return self.collectionView.contentOffset
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: -
    private func configure() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        view.addSubview(selector)
        NSLayoutConstraint.activate([
            selector.heightAnchor.constraint(equalTo: collectionView.heightAnchor),
            selector.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            selector.widthAnchor.constraint(equalToConstant: 3),
            selector.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor),
            
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func findCenterIndex() -> IndexPath? {
        let center = view.convert(collectionView.center, to: collectionView)
        let index = collectionView.indexPathForItem(at: center)
        return index
    }
    
    public func scrollToLastItem() {
        let speed: CGFloat = 8
        let co = collectionView.contentOffset.x
        let no = co + speed
        let cellWidth: CGFloat = 50
        UIView.animate(withDuration: 0.0014, delay: 0, options: .curveEaseIn, animations: { [weak self] in
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
        delegate?.framesPickerView?(self, didSelectItem: selectedItem)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let index = findCenterIndex() else { return }
        collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 50, height: 50)
        return delegate?.framesPickerView?(self, sizeForItem: indexPath.row) ?? size
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let number = self.collectionView.numberOfItems(inSection: section)
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

extension FramesPickerView: HasDelegate {
    public typealias Delegate = FramesPickerViewDelegate
}

//MARK: - RxDelegateProxy
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

extension Reactive where Base: FramesPickerView {
    
    func setDelegate(_ delegate: FramesPickerViewDelegate) -> Disposable {
        return FramesPickerViewDelegateProxy.installForwardDelegate(delegate, retainDelegate: false, onProxyForObject: base)
    }

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
