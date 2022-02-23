//
//  ViewControllerExtensions.swift
//  Auth
//
//  Created by Adam Cseke on 2022. 02. 18..
//  Copyright © 2022. levivig. All rights reserved.
//

import UIKit

extension UIViewController {
 
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
