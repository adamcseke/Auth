//
//  VerificationPresenter.swift
//  Auth
//
//  Created by Adam Cseke on 2022. 02. 21..
//  Copyright (c) 2022. levivig. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation

final class VerificationPresenter {

    // MARK: - Private properties -

    private unowned let view: VerificationViewInterface
    private let interactor: VerificationInteractorInterface
    private let wireframe: VerificationWireframeInterface
    
    private var currentInput: String = ""
    private var phoneNumber: String = ""
    // MARK: - Lifecycle -

    init(
        view: VerificationViewInterface,
        interactor: VerificationInteractorInterface,
        wireframe: VerificationWireframeInterface,
        phoneNumber: String
    ) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        self.phoneNumber = phoneNumber
    }
    
    func viewDidLoad() {
        view.pushPhoneNumber(phoneNumber: phoneNumber)
    }
}

// MARK: - Extensions -

extension VerificationPresenter: VerificationPresenterInterface {
    func changePhoneNumberButtonTapped() {
        wireframe.backToHome()
    }
    
    func nextButtonTapped(phoneNumber: String) {
        self.phoneNumber = phoneNumber
        wireframe.goToLogin(phoneNumber: phoneNumber)
    }
    
    func presentAlert() {
        wireframe.presentAlert()
    }
    
    func inputChanged(text: String) {
        
        self.currentInput = text
        
        view.setButton(enable: text.count == 6)
        
    }
}
