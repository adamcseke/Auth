//
//  Button.swift
//  Auth
//
//  Created by Adam Cseke on 2022. 02. 18..
//  Copyright © 2022. levivig. All rights reserved.
//

import UIKit

class Button: UIControl {
    
    private var buttonLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        configureButton()
        configureLabel()
    }
    
    private func configureButton() {
        layer.cornerRadius = 11
        isUserInteractionEnabled = true
        isEnabled = false
    }
    
    private func configureLabel() {
        buttonLabel = UILabel()
        buttonLabel.textColor = .white
        buttonLabel.font = UIFont(name: "Hind-Bold", size: 20)
        buttonLabel.textAlignment = .center
        
        addSubview(buttonLabel)
        
        buttonLabel.snp.makeConstraints { make in
            make.leading.centerX.centerY.equalToSuperview()
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                backgroundColor = Colors.button
            } else {
                backgroundColor = Colors.button.withAlphaComponent(0.5)
                
            }
        }
    }
    
    func bind(buttonLabelText: String, font: UIFont, textColor: UIColor) {
        buttonLabel.text = buttonLabelText
        buttonLabel.font = font
        buttonLabel.textColor = textColor
    }
}
