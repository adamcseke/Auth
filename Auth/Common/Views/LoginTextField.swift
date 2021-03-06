//
//  LoginTextField.swift
//  Auth
//
//  Created by Adam Cseke on 2022. 02. 24..
//  Copyright © 2022. levivig. All rights reserved.
//

import UIKit

protocol LoginTextFieldDelegate: AnyObject {
    func textfieldValueDidChange(text: String)
}

class LoginTextField: UITextField {
    
    weak var customDelegate: LoginTextFieldDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
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
        textAlignment = .center
        font = UIFont(name: "Hind", size: 12)
        autocorrectionType = .no
        autocapitalizationType = .none
        keyboardType = .default
        textColor = .black
        isSecureTextEntry = true
        addTarget(self, action: #selector(textfieldValueChanged), for: .editingChanged)
    }
    
    @objc private func textfieldValueChanged() {
        customDelegate?.textfieldValueDidChange(text: text ?? "")
    }
}
