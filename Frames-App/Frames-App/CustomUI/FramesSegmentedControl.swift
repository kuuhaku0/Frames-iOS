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
    static let segmentedControlBackgroundColor = Palette.colorFromRGB(237, green: 242, blue: 247, alpha: 0.7)
    static let sliderColor = Palette.colorFromRGB(44, green: 131, blue: 255)
    
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
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    func removeShadow() {
        layer.shadowOpacity = 0
    }
}

public class SegmentControl: UIControl {
    
    public static let height: CGFloat = Constants.height + Constants.topBottomMargin * 2
    
    private struct Constants {
        static let height: CGFloat = 40
        static let topBottomMargin: CGFloat = 0
        static let leadingTrailingMargin: CGFloat = 0
    }
    
    
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
            sliderMaskView.addShadow(with: .black)
        }
    }
    
    private var correction: CGFloat = 0
    
    open weak var delegate: FramesSegmentControlDelegate?
    
    private(set) open var selectedSegmentIndex: Int = 0
    
    private var segments: [UIImage] = []
    
    private var numberOfSegments: Int {
        return segments.count
    }
    
    let offset: CGFloat = 5
    
    private var segmentWidth: CGFloat {
        return (self.backgroundView.frame.width) / CGFloat(numberOfSegments)
    }
    
    private lazy var containerView: UIView = UIView()
    private lazy var backgroundView: UIView = UIView()
    private lazy var selectedContainerView: UIView = UIView()
    private lazy var sliderView: SliderView = SliderView()
    
    open var segmentsBackgroundColor: UIColor = Palette.segmentedControlBackgroundColor {
        didSet {
            backgroundView.backgroundColor = segmentsBackgroundColor
        }
    }
    
    open var sliderBackgroundColor: UIColor = Palette.sliderColor {
        didSet {
            selectedContainerView.backgroundColor = sliderBackgroundColor
            if !isSliderShadowHidden { selectedContainerView.addShadow(with: sliderBackgroundColor) }
        }
    }
    
    open var isSliderShadowHidden: Bool = false {
        didSet {
            updateShadow(with: .black, hidden: isSliderShadowHidden)
        }
    }
    
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
        containerView.addSubview(backgroundView)
        containerView.addSubview(selectedContainerView)
        containerView.addSubview(sliderView)
        
        selectedContainerView.layer.mask = sliderView.sliderMaskView.layer
        addTapGesture()
        addDragGesture()
        self.clipsToBounds = false
    }
    
    open func setSegmentItems(_ segments: [UIImage]) {
        guard !segments.isEmpty else { fatalError("Segments array cannot be empty") }
        
        self.segments = segments
        configureViews()
        
        for (index, image) in segments.enumerated() {
            let baseImageView = createImageView(with: image, at: index, selected: false)
            baseImageView.tintColor = Palette.colorFromRGB(100, green: 100, blue: 100)
            let selectedImageView = createImageView(with: image, at: index, selected: true)
            selectedImageView.tintColor = UIColor.black
            selectedImageView.addShadow(with: .black)
            baseImageView.removeShadow()
            backgroundView.addSubview(baseImageView)
            backgroundView.backgroundColor = .clear
            selectedContainerView.addSubview(selectedImageView)
        }
        
        setupAutoresizingMasks()
    }
    
    private func setupAutoresizingMasks() {
        containerView.autoresizingMask = [.flexibleWidth]
        backgroundView.autoresizingMask = [.flexibleWidth]
        selectedContainerView.autoresizingMask = [.flexibleWidth]
        sliderView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleWidth]
    }
    
    private func updateShadow(with color: UIColor, hidden: Bool) {
        if hidden {
            selectedContainerView.removeShadow()
            sliderView.sliderMaskView.removeShadow()
        } else {
            selectedContainerView.addShadow(with: sliderBackgroundColor)
            sliderView.sliderMaskView.addShadow(with: .black)
        }
    }
    
    private func configureViews() {
        self.layer.cornerRadius = CGFloat(self.cornerRadius)
        containerView.frame = CGRect(x: Constants.leadingTrailingMargin,
                                     y: Constants.topBottomMargin,
                                     width: bounds.width - Constants.leadingTrailingMargin * 2,
                                     height: Constants.height)
        let frame = containerView.bounds
        backgroundView.frame = frame
        selectedContainerView.frame = frame
        sliderView.frame = CGRect(x: 0, y: 0, width: segmentWidth, height: backgroundView.frame.height)
        
        [backgroundView, selectedContainerView].forEach { $0.layer.cornerRadius = CGFloat(cornerRadius) }
        sliderView.cornerRadius = cornerRadius
        
        backgroundColor = .white
        backgroundView.backgroundColor = segmentsBackgroundColor
        selectedContainerView.backgroundColor = sliderBackgroundColor
        
        if !isSliderShadowHidden {
            selectedContainerView.addShadow(with: sliderBackgroundColor)
        }
    }
    
    private func createImageView(with image: UIImage, at index: Int, selected: Bool) -> UIImageView {
        let rect = CGRect(x: CGFloat(index) * segmentWidth + offset, y: (backgroundView.bounds.height - segmentWidth) / 2, width: segmentWidth - offset * 2, height: segmentWidth - offset * 2)
        let imageView = UIImageView(frame: rect)
        imageView.center.y = containerView.center.y
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        imageView.clipsToBounds = true
        imageView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleWidth]
        return imageView
    }
    
    // MARK: - Gestures
    private func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tap)
    }
    
    private func addDragGesture() {
        let drag = UIPanGestureRecognizer(target: self, action: #selector(didPan))
        sliderView.addGestureRecognizer(drag)
    }
    
    @objc private func didTap(tapGesture: UITapGestureRecognizer) {
        moveToNearestPoint(basedOn: tapGesture)
    }
    
    @objc private func didPan(panGesture: UIPanGestureRecognizer) {
        switch panGesture.state {
        case .cancelled, .ended, .failed:
            moveToNearestPoint(basedOn: panGesture, velocity: panGesture.velocity(in: sliderView))
        case .began:
            correction = panGesture.location(in: sliderView).x - sliderView.frame.width/2
        case .changed:
            let location = panGesture.location(in: self)
            sliderView.center.x = location.x - correction
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
        var index = Int(point.x / sliderView.frame.width)
        if index < 0 { index = 0 }
        if index > numberOfSegments - 1 { index = numberOfSegments - 1 }
        return index
    }
    
    private func center(at index: Int) -> CGFloat {
        let xOffset = CGFloat(index) * sliderView.frame.width + sliderView.frame.width / 2
        return xOffset
    }
    
    private func animate(to position: CGFloat) {
        UIView.animate(withDuration: 0.2) {
            self.sliderView.center.x = position
        }
    }
}
