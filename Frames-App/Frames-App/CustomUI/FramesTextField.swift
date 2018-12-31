//
//  FramesTextField.swift
//  Frames-App
//
//  Created by Tyler Zhao on 12/10/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit

@IBDesignable 
class FramesTextField: UITextField {

    @IBInspectable lazy var underline = UIView()
    @IBInspectable lazy var titleLabel: UILabel = { [unowned self] in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    @IBInspectable lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    @IBInspectable
    open var underlineColor: UIColor? {
        get {
            return underline.backgroundColor
        }
        set(value) {
            underline.backgroundColor = value
            layoutSubviews()
        }
    }
    
    @IBInspectable
    open var title: String? {
        get {
            return titleLabel.text
        }
        set(value) {
            titleLabel.text = value
            layoutSubviews()
        }
    }
    
    @IBInspectable
    open var textFieldDescription: String? {
        get {
            return descriptionLabel.text
        }
        set(value) {
            descriptionLabel.text = value
            layoutSubviews()
        }
    }
    
    @objc
    open var textInset: CGFloat {
        guard let font = font else { return 0 }
        let underlinePadding: CGFloat = 5.0
        return (frame.height / 2) - (font.pointSize / 2) - underlinePadding
    }
    
    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        var inset = super.textRect(forBounds: bounds)
        inset.origin.y += textInset
        return inset
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
//    override var intrinsicContentSize: CGSize {
//        return CGSize(width: bounds.width, height: calculateHeight())
//    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        tintColor = .black
        borderStyle = .none
        clipsToBounds = false
        font = UIFont.systemFont(ofSize: 14)
        
        drawTitleLabel()
        drawDescriptionLabel()
        drawUnderline()
    }
    
    private func calculateHeight() -> CGFloat {
        let underlineHeight = underline.bounds.height
        let padding: CGFloat = 5
        let titleLabelHeight: CGFloat = titleLabel.hasNoText ? 0 : titleLabel.bounds.height
        let descriptionLabelHeight: CGFloat = descriptionLabel.hasNoText ? 0 : descriptionLabel.bounds.height
        // TODO: - 
        let totalHeight: CGFloat = underlineHeight + padding * 2 + titleLabelHeight + descriptionLabelHeight
        return 69
    }
    
    private func drawTitleLabel() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: titleLabel.font.pointSize)
        ])
    }
    
    private func drawDescriptionLabel() {
        addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: descriptionLabel.font.pointSize),
        ])
    }
    
    private func drawUnderline() {
        addSubview(underline)
        underline.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            underline.leadingAnchor.constraint(equalTo: leadingAnchor),
            underline.trailingAnchor.constraint(equalTo: trailingAnchor),
            underline.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
            underline.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
}
