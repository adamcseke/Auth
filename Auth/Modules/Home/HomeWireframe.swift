//
//  HomeWireframe.swift
//  Auth
//
//  Created by Adam Cseke on 2022. 02. 18..
//  Copyright (c) 2022. levivig. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class HomeWireframe: BaseWireframe {

    // MARK: - Module setup -

    init(country: String, flag: String) {
        let moduleViewController = HomeViewController()
        super.init(viewController: moduleViewController)
        
        let interactor = HomeInteractor()
        let presenter = HomePresenter(view: moduleViewController, interactor: interactor, wireframe: self, country: country, flag: flag)
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension HomeWireframe: HomeWireframeInterface {
    func goToLogin() {
        let loginVC = LoginWireframe(phoneNumber: "")
        navigationController?.pushWireframe(loginVC)
    }
    
    func goToCountryPicker(delegate: HomeDelegate?) {
        let counrtyPickerWireFrame = CountryPickerWireframe(delegate: delegate)
        navigationController?.presentWireframe(counrtyPickerWireFrame)
    }
    
    func goToVerification(phoneNumber: String) {
        let verificationWireframe = VerificationWireframe(phoneNumber: phoneNumber)
        navigationController?.pushWireframe(verificationWireframe)
    }
}
