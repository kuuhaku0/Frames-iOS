//
//  FramesTextFieldCell.swift
//  Frames-App
//
//  Created by Tyler Zhao on 12/27/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit

class FramesTextFieldCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        lb.textColor = UIColor(hexString: "333333")
        lb.numberOfLines = 2
        return lb
    }()
    
    lazy var descriptionLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        lb.textColor = UIColor(hexString: "666666")
        lb.numberOfLines = 2
        return lb
    }()
    
    lazy var textField = FramesTextField()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 5
        sv.setContentHuggingPriority(UILayoutPriority.required, for: .vertical)
        return sv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        textField.underlineColor = .black
        setupStackView()
        setupTextField()
    }
    
    func configure(title: String, description: String?, placeHolder: String) {
        titleLabel.text = title
        guard let text = description else { descriptionLabel.isHidden = true; return }
        descriptionLabel.text = text
        textField.placeholder = placeHolder
    }
    
    private func setupStackView() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        NSLayoutConstraint.activate([stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
                                     stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
                                     stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)])
    }
    
    private func setupTextField() {
        contentView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([textField.widthAnchor.constraint(equalTo: stackView.widthAnchor),
                                     textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                                     textField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                                     textField.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10)])
    }
}
