//
//  AttributedCustomButton.swift
//  Auth
//
//  Created by Adam Cseke on 2022. 02. 22..
//  Copyright © 2022. levivig. All rights reserved.
//

import UIKit

enum CustomButtonTypes {
    case enabled
    case disabled
}

class AttributedCustomButton: UIButton {
    
    private var customButtonTypes: CustomButtonTypes?
    private let style = NSMutableParagraphStyle()
    
    private var titleText: String?
    private var subtitleText: String?
    
    private var attributesRegularEnabled: [NSAttributedString.Key: Any] = [:]
    private var attributesSecondsBoldEnabled: [NSAttributedString.Key : Any] = [:]
    private var attributesRegularNotEnabled: [NSAttributedString.Key: Any] = [:]
    
    init(title: String, subtitle: String) {
        super.init(frame: .zero)
        self.titleText = title
        self.subtitleText = subtitle
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        configureButtonTypes()
    }
    
    private func configureButtonTypes() {
        style.alignment = NSTextAlignment.center
        
        titleLabel?.numberOfLines = 1
        
        attributesRegularEnabled = [
            NSAttributedString.Key.foregroundColor: Colors.button,
            NSAttributedString.Key.font: UIFont(name: "Hind-Regular", size: 16),
            NSAttributedString.Key.paragraphStyle: style
        ]
        
        attributesSecondsBoldEnabled = [
            NSAttributedString.Key.foregroundColor: Colors.button,
            NSAttributedString.Key.font: UIFont(name: "Hind-Bold", size: 16),
            NSAttributedString.Key.paragraphStyle: style
        ]
        
        attributesRegularNotEnabled = [
            NSAttributedString.Key.foregroundColor: Colors.button.withAlphaComponent(0.5),
            NSAttributedString.Key.font: UIFont(name: "Hind-Regular", size: 16),
            NSAttributedString.Key.paragraphStyle: style
        ]
        
    }
    
    func bind(title:String, subTitle:String, buttonType: CustomButtonTypes) {
        switch buttonType {
            
        case .enabled:
            let attributedStringIfEnabled = NSMutableAttributedString(string: title, attributes: attributesRegularEnabled)
            attributedStringIfEnabled.append(NSAttributedString(string: subTitle, attributes: attributesSecondsBoldEnabled))
            
            setAttributedTitle(attributedStringIfEnabled, for: UIControl.State.normal)
            
        case .disabled:
            let attributedStringIfNotEnabled = NSMutableAttributedString(string: title, attributes: attributesRegularNotEnabled)
            attributedStringIfNotEnabled.append(NSAttributedString(string: subTitle, attributes: attributesSecondsBoldEnabled))
            
            setAttributedTitle(attributedStringIfNotEnabled, for: UIControl.State.normal)
        }
    }
    
}
