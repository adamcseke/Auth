//
//  CountryPickerWireframe.swift
//  Auth
//
//  Created by Adam Cseke on 2022. 02. 22..
//  Copyright (c) 2022. levivig. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class CountryPickerWireframe: BaseWireframe {
    
    private weak var homeDelegate: HomeDelegate?

    // MARK: - Module setup -

    init(delegate: HomeDelegate?) {
        let moduleViewController = CountryPickerViewController()
        super.init(viewController: moduleViewController)
        
        self.homeDelegate = delegate
        
        let interactor = CountryPickerInteractor()
        let presenter = CountryPickerPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension CountryPickerWireframe: CountryPickerWireframeInterface {
    func dismissCountryPicker(country: String, flag: String) {
        homeDelegate?.countrySelected(country: country, flag: flag)
    }
}
