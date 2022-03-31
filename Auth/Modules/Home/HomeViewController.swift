//
//  HomeViewController.swift
//  Auth
//
//  Created by Adam Cseke on 2022. 02. 18..
//  Copyright (c) 2022. levivig. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class HomeViewController: BaseViewController {
    
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var phoneNumberTextField: PhoneNumberTextField!
    private var nextButton: Button!
    private var countryPickerButton: UIButton!
    private var country: String?
    private var countryFlag: String = ""
    private var downArrowImageView: UIImageView!
    
    private var phoneNumber: String?
    private var savedPhoneNumber: String?
    
    // MARK: - Public properties -
    var presenter: HomePresenterInterface!
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        configureTitleLabel()
        configureDescriptionLabel()
        configurePhoneNumberTextfield()
        configureCountryPickerButton()
        configureDownArrowImageView()
        configureButton()
        hideKeyboardWhenTappedAround()
        configurePushUpView()
    }
    
    private func configurePushUpView() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func configureTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "HomeViewController.TitleLabel".localized
        titleLabel.textColor = Colors.blackLabel
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Hind-Bold", size: 24)
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(0.53)
            make.leading.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.text = "HomeViewController.DescriptionLabel".localized
        descriptionLabel.textColor = Colors.blackLabel
        descriptionLabel.numberOfLines = 5
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont(name: "Hind-Regular", size: 15)
        view.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configurePhoneNumberTextfield() {
        phoneNumberTextField = PhoneNumberTextField()
        phoneNumberTextField.delegate = self
        phoneNumberTextField.textAlignment = .left
        
        view.addSubview(phoneNumberTextField)
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.height.equalTo(50)
        }
    }
    
    private func configureCountryPickerButton() {
        countryPickerButton = UIButton(type: .custom)
        countryPickerButton.addTarget(self, action: #selector(didTapCountryPickerButton), for: .touchUpInside)
        countryPickerButton.titleLabel?.font = .systemFont(ofSize: 20)
        countryPickerButton.setTitle("📍", for: .normal)
        
        view.addSubview(countryPickerButton)
        
        countryPickerButton.snp.makeConstraints { make in
            make.centerY.equalTo(phoneNumberTextField.snp.centerY)
            make.leading.equalTo(phoneNumberTextField.snp.leading).offset(8)
            
        }
    }
    
    @objc private func didTapCountryPickerButton() {
        presenter.countryPickerButtonTapped()
    }
    
    private func configureDownArrowImageView() {
            downArrowImageView = UIImageView()
            downArrowImageView.image = UIImage(systemName: "chevron.down")
            downArrowImageView.tintColor = Colors.downArrow
            view.addSubview(downArrowImageView)
            
            downArrowImageView.snp.makeConstraints { make in
                make.centerY.equalTo(phoneNumberTextField.snp.centerY)
                make.leading.equalTo(countryPickerButton.snp.trailing)
            }
        }
    
    private func configureButton() {
        nextButton = Button()
        nextButton.bind( buttonLabelText: "HomeViewController.ButtonTitle".localized,
                         font: UIFont(name: "Hind-Bold", size: 16) ?? UIFont(),
                         textColor: .white)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        view.addSubview(nextButton)
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.height.equalTo(50)
        }
    }
    
    @objc private func nextButtonTapped() {
        let user = UserInfo(phoneNumber: self.phoneNumber ?? "")
        let encoder = JSONEncoder()
        if let encodedUser = try? encoder.encode(user) {
            UserDefaults.standard.set(encodedUser, forKey: "user")
        }
        presenter.nextButtonTapped()
    }
}

// MARK: - Extensions -

extension HomeViewController: HomeViewInterface {
    func setCountry(country: String, flag: String) {
        phoneNumberTextField.text?.removeAll()
        phoneNumberTextField.text?.append(country)
        let selectedCountryFlag = CountryCodes.flag(country: flag).decodeEmoji
        countryPickerButton.setTitle(selectedCountryFlag, for: .normal)
        
    }
    
    func setButton(enable: Bool) {
        if enable {
            nextButton.isEnabled = true
            nextButton.backgroundColor = Colors.button
        } else {
            nextButton.isEnabled = false
            nextButton.backgroundColor = Colors.button.withAlphaComponent(0.5)
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height * 0.30
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

extension HomeViewController: UITextFieldDelegate {
    
    func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator
        
        for character in mask where index < numbers.endIndex {
            if character == "X" {
                
                result.append(numbers[index])

                index = numbers.index(after: index)
                
            } else {
                result.append(character)
            }
        }
        return result
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = format(with: "+XXXXXXXXXXXXXXX", phone: newString)
        presenter.inputChanged(text: textField.text ?? "")
        let phoneNumberValidator = textField.text?.isPhoneNumber
        if phoneNumberValidator == true {
            self.phoneNumber = textField.text ?? ""
        }
        return false
    }
}
