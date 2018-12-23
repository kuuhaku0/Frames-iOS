//
//  FramesSegmentedControl.swift
//  Frames-App
//
//  Created by Tyler Zhao on 12/7/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import Foundation

import UIKit

public protocol FramesSegmentControlDelegate: AnyObject {
    func segmentControl(_ segmentControl: SegmentControl, didSelectSegment index: Int)
}

struct Palette {
    static let defaultTextColor = Palette.colorFromRGB(9, green: 26, blue: 51, alpha: 0.4)
    static let highlightTextColor = UIColor.white
    static let segmentedControlBackgroundColor = Palette.colorFromRGB(221, green: 221, blue: 221, alpha: 1)
    static let sliderColor = UIColor.white
    
    static func colorFromRGB(_ red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        func amount(_ amount: CGFloat, with alpha: CGFloat) -> CGFloat {
            return (1 - alpha) * 255 + alpha * amount
        }
        
        let red = amount(red, with: alpha)/255
        let green = amount(green, with: alpha)/255
        let blue = amount(blue, with: alpha)/255
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}

extension UIView {
    func addShadow(with color: UIColor) {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowRadius = 4
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    func removeShadow() {
        layer.shadowOpacity = 0
    }
}

public class SegmentControl: UIControl {
    
    class SliderView: UIView {
        // MARK: - Properties
        fileprivate let sliderMaskView = UIView()
        
        override var frame: CGRect {
            didSet {
                sliderMaskView.frame = frame
            }
        }
        
        override var center: CGPoint {
            didSet {
                sliderMaskView.center = center
            }
        }
        
        init() {
            super.init(frame: .zero)
            setup()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setup()
        }
        
        private func setup() {
            layer.masksToBounds = true
            sliderMaskView.backgroundColor = .white
            sliderMaskView.cornerRadius = 2
        }
    }
    
    public static let height: CGFloat = Constants.height + Constants.topBottomMargin * 2
    
    private struct Constants {
        static let height: CGFloat = 30
        static let topBottomMargin: CGFloat = 0
        static let leadingTrailingMargin: CGFloat = 0
    }
    
    open weak var delegate: FramesSegmentControlDelegate?
    
    private(set) open var selectedSegmentIndex: Int = 0
    private var segments: [UIImage] = []
    private var numberOfSegments: Int {
        return segments.count
    }
    
    private var correction: CGFloat = 0
    private let offset: CGFloat = 5
    
    private var segmentWidth: CGFloat {
        return (self.segmentControlBackgroundView.frame.width) / CGFloat(numberOfSegments)
    }
    
    private lazy var containerView: UIView = UIView()
    private lazy var segmentControlBackgroundView: UIView = UIView()
    
    // Selection Slider
    private lazy var selectionSliderShadowView: UIView = UIView()
    private lazy var selectionSliderItemContainerView: UIView = UIView()
    private lazy var selectionSliderView: SliderView = SliderView()
    
    private var segmentImageView: UIImageView?
    private var selectedImageView: UIImageView?
    
    //Mark: - Open Configurations
    /// Background color of segmented control
    open var segmentControlBackgroundColor: UIColor = Palette.segmentedControlBackgroundColor {
        didSet {
            segmentControlBackgroundView.backgroundColor = segmentControlBackgroundColor
        }
    }
    
    /// Background color for selection slider
    open var sliderBackgroundColor: UIColor = Palette.sliderColor {
        didSet {
            selectionSliderShadowView.backgroundColor = sliderBackgroundColor
            if !isSliderShadowHidden { selectionSliderShadowView.addShadow(with: sliderBackgroundColor) }
        }
    }
    
    /// Hides and unhides shadow for selection slider
    open var isSliderShadowHidden: Bool = false {
        didSet {
            updateShadow(with: .black, hidden: isSliderShadowHidden)
        }
    }
    
    open var segmentCornerRadius: Double = 2 {
        didSet {
            cornerRadius = segmentCornerRadius
            segmentControlBackgroundView.cornerRadius = segmentCornerRadius
            containerView.cornerRadius = segmentCornerRadius
        }
    }
    
    // MARK: - Initializers
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        addSubview(containerView)
        containerView.addSubview(segmentControlBackgroundView)
        containerView.addSubview(selectionSliderShadowView)
        containerView.addSubview(selectionSliderItemContainerView)
        containerView.addSubview(selectionSliderView)
        
        selectionSliderItemContainerView.layer.mask = selectionSliderView.sliderMaskView.layer
        addTapGesture()
        addDragGesture()
        self.clipsToBounds = false
    }
    
    private func configureViews() {
        self.layer.cornerRadius = CGFloat(segmentCornerRadius)
        containerView.frame = CGRect(x: Constants.leadingTrailingMargin,
                                     y: Constants.topBottomMargin,
                                     width: bounds.width - Constants.leadingTrailingMargin * 2,
                                     height: Constants.height)
        let frame = containerView.bounds
        segmentControlBackgroundView.frame = frame
        selectionSliderItemContainerView.frame = frame
        selectionSliderShadowView.frame = CGRect(x: 0, y: 0, width: segmentWidth, height: segmentControlBackgroundView.frame.height)
        selectionSliderView.frame = CGRect(x: 0, y: 0, width: segmentWidth, height: segmentControlBackgroundView.frame.height)
        
        [segmentControlBackgroundView, selectionSliderShadowView, selectionSliderItemContainerView].forEach { $0.layer.cornerRadius = CGFloat(segmentCornerRadius) }
        selectionSliderView.cornerRadius = segmentCornerRadius
        
        backgroundColor = .clear
        segmentControlBackgroundView.backgroundColor = segmentControlBackgroundColor
        selectionSliderItemContainerView.backgroundColor = .clear
        selectionSliderShadowView.backgroundColor = sliderBackgroundColor
        
        if !isSliderShadowHidden {
            selectionSliderShadowView.addShadow(with: sliderBackgroundColor)
        }
    }
    
    open func setSegmentItems(_ segments: [UIImage]) {
        guard !segments.isEmpty else { fatalError("Segments array cannot be empty") }
        
        self.segments = segments
        configureViews()
        
        for (index, image) in segments.enumerated() {
            let baseImageView = createImageView(with: image, at: index, selected: false)
            let selectedImageView = createImageView(with: image, at: index, selected: true)
            segmentControlBackgroundView.addSubview(baseImageView)
            selectionSliderItemContainerView.addSubview(selectedImageView)
        }
        setupAutoresizingMasks()
    }
    
    private func createImageView(with image: UIImage, at index: Int, selected: Bool) -> UIImageView {
        let rect = CGRect(x: CGFloat(index) * segmentWidth + offset,
                          y: (segmentControlBackgroundView.bounds.height - segmentWidth) / 2,
                          width: segmentWidth - offset * 2,
                          height: segmentWidth - offset * 2)
        
        let imageView = UIImageView(frame: rect)
        imageView.center.y = containerView.center.y
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        imageView.clipsToBounds = true
        imageView.tintColor = selected ?
            UIColor.black:
            Palette.colorFromRGB(153, green: 153, blue: 153)
        imageView.cornerRadius = segmentCornerRadius
        imageView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleWidth]
        return imageView
    }
    
    private func setupAutoresizingMasks() {
        containerView.autoresizingMask = [.flexibleWidth]
        segmentControlBackgroundView.autoresizingMask = [.flexibleWidth]
        selectionSliderShadowView.autoresizingMask = [.flexibleWidth]
        selectionSliderView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleWidth]
    }
    
    private func updateShadow(with color: UIColor, hidden: Bool) {
        if hidden {
            selectionSliderShadowView.removeShadow()
            selectionSliderView.sliderMaskView.removeShadow()
        } else {
            selectionSliderShadowView.addShadow(with: sliderBackgroundColor)
            selectionSliderView.sliderMaskView.addShadow(with: .black)
        }
    }
    
    // MARK: - Gestures
    private func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tap)
    }
    
    private func addDragGesture() {
        let drag = UIPanGestureRecognizer(target: self, action: #selector(didPan))
        selectionSliderView.addGestureRecognizer(drag)
    }
    
    @objc private func didTap(tapGesture: UITapGestureRecognizer) {
        moveToNearestPoint(basedOn: tapGesture)
    }
    
    // TODO: - Make selectedSegmentView stay in bounds of containerView and still feel smooth
    @objc private func didPan(panGesture: UIPanGestureRecognizer) {
        let location = panGesture.location(in: self)
        let xPos = location.x - correction
        
        switch panGesture.state {
        case .cancelled, .ended, .failed:
            moveToNearestPoint(basedOn: panGesture, velocity: panGesture.velocity(in: selectionSliderView))
        case .began:
            if xPos < 0 {
                selectionSliderView.center.x = 0
                selectionSliderShadowView.center.x = xPos
                
            } else if xPos > containerView.bounds.maxX {
                selectionSliderView.center.x = containerView.bounds.maxX - selectionSliderView.frame.width / 2
                selectionSliderShadowView.center.x = xPos
                
            }
            correction = panGesture.location(in: selectionSliderView).x - selectionSliderView.bounds.width/2
        case .changed:
            guard panGesture.location(in: self).x - correction >= containerView.bounds.minX,
                panGesture.location(in: self).x - correction <= containerView.bounds.maxX else {return}
            selectionSliderView.center.x = xPos
            selectionSliderShadowView.center.x = xPos
            
        case .possible: ()
        }
    }
    
    // MARK: - Move
    open func move(to index: Int) {
        let correctOffset = center(at: index)
        animate(to: correctOffset)
        selectedSegmentIndex = index
    }
    
    private func moveToNearestPoint(basedOn gesture: UIGestureRecognizer, velocity: CGPoint? = nil) {
        var location = gesture.location(in: self)
        if let velocity = velocity {
            let offset = velocity.x / 12
            location.x += offset
        }
        let index = segmentIndex(for: location)
        move(to: index)
        delegate?.segmentControl(self, didSelectSegment: index)
    }
    
    private func segmentIndex(for point: CGPoint) -> Int {
        var index = Int(point.x / selectionSliderView.frame.width)
        if index < 0 { index = 0 }
        if index > numberOfSegments - 1 { index = numberOfSegments - 1 }
        return index
    }
    
    private func center(at index: Int) -> CGFloat {
        let xOffset = CGFloat(index) * selectionSliderView.frame.width + selectionSliderView.frame.width / 2
        return xOffset
    }
    
    private func animate(to position: CGFloat) {
        UIView.animate(withDuration: 0.2) {
            self.selectionSliderView.center.x = position
            self.selectionSliderShadowView.center.x = position
        }
    }
}

