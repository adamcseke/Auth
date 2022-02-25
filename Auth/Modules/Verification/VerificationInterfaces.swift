//
//  VerificationInterfaces.swift
//  Auth
//
//  Created by Adam Cseke on 2022. 02. 21..
//  Copyright (c) 2022. levivig. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

protocol VerificationWireframeInterface: WireframeInterface {
    func goToLogin(phoneNumber: String)
    func backToHome()
}

protocol VerificationViewInterface: ViewInterface {
    func setButton(enable: Bool)
    func pushPhoneNumber(phoneNumber: String)
}

protocol VerificationPresenterInterface: PresenterInterface {
    func nextButtonTapped(phoneNumber: String)
    func inputChanged(text: String)
    func changePhoneNumberButtonTapped()
}

protocol VerificationInteractorInterface: InteractorInterface {
}
