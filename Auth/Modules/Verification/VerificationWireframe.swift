//
//  VerificationWireframe.swift
//  Auth
//
//  Created by Adam Cseke on 2022. 02. 21..
//  Copyright (c) 2022. levivig. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class VerificationWireframe: BaseWireframe {

    // MARK: - Module setup -

    init(phoneNumber: String) {
        let moduleViewController = VerificationViewController()
        super.init(viewController: moduleViewController)
        
        let interactor = VerificationInteractor()
        let presenter = VerificationPresenter(view: moduleViewController, interactor: interactor, wireframe: self, phoneNumber: phoneNumber)
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension VerificationWireframe: VerificationWireframeInterface {
}