//
//  PhoneNumberTextField.swift
//  Auth
//
//  Created by Adam Cseke on 2022. 02. 18..
//  Copyright © 2022. levivig. All rights reserved.
//

import UIKit

protocol PhoneNumberTextfieldDelegate: AnyObject {
    func textfieldValueDidChange(text: String)
}

class PhoneNumberTextField: UITextField {
    
    var textPadding = UIEdgeInsets( top: 10, left: 60, bottom: 10, right: 20)
    
    weak var customDelegate: PhoneNumberTextfieldDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
            let rect = super.textRect(forBounds: bounds)
            return rect.inset(by: textPadding)
        }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
            let rect = super.editingRect(forBounds: bounds)
            return rect.inset(by: textPadding)
        }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        configureTextfield()
    }
    
    private func configureTextfield() {
        layer.cornerRadius = 11
        backgroundColor = .white
        textAlignment = .left
        font = UIFont(name: "Hind-Medium", size: 16)
        addTarget(self, action: #selector(textfieldValueChanged), for: .editingChanged)
        placeholder = "HomeViewController.TextField.Registration".localized
        keyboardType = .numberPad
        backgroundColor = .white
        autocorrectionType = .no
        layer.cornerRadius = 11
    }
    
    @objc private func textfieldValueChanged() {
        customDelegate?.textfieldValueDidChange(text: text ?? "")
    }
}
