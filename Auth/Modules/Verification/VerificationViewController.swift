//
//  VerificationViewController.swift
//  Auth
//
//  Created by Adam Cseke on 2022. 02. 21..
//  Copyright (c) 2022. levivig. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class VerificationViewController: UIViewController {
    
    private var timer: Timer?
    private var seconds = 5
    
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var verificationCodeTextfield: LoginTextField!
    private var nextButton: Button!
    private var stackView: UIStackView!
    private var incorrectPasswordLabel: UILabel!
    private var sendAgainButton: AttributedCustomButton!
    private var secondsLabel: UILabel!
    private var attributeString = NSMutableAttributedString()
    private var changePhoneNumberButton: UIButton!
    private var phoneNumber: String?
    private var password: String?
    // MARK: - Public properties -
    var presenter: VerificationPresenterInterface!
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter.viewDidLoad()
    }
    
    private func setup() {
        configureViewController()
        configureTitleLabel()
        configureDescriptionLabel()
        configurePinCodeTextfield()
        configureNextButton()
        configureStackView()
        configureIncorrectPassword()
        configureSendAgainButton()
        configureChangePhoneNumberButton()
        hideKeyboardWhenTappedAround()
        configurePushUpView()
    }
    
    private func configureViewController() {
        view.backgroundColor = Colors.background
    }
    
    private func configurePushUpView() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func configureTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "VerificationViewController.TitleLabel".localized
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
        descriptionLabel.textColor = Colors.blackLabel
        descriptionLabel.numberOfLines = 5
        descriptionLabel.textAlignment = .center
        view.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configurePinCodeTextfield() {
        verificationCodeTextfield = LoginTextField()
        verificationCodeTextfield.font = UIFont(name: "Hind-SemiBold", size: 20)
        verificationCodeTextfield.customDelegate = self
        
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold),
            NSAttributedString.Key.foregroundColor: Colors.placeholder
        ]
        
        let attributedPlaceholder = NSMutableAttributedString(string: "VerificationViewController.TextField.Placeholder".localized, attributes: attributes)
        verificationCodeTextfield.attributedPlaceholder = attributedPlaceholder
        
        view.addSubview(verificationCodeTextfield)
        
        verificationCodeTextfield.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.height.equalTo(50)
        }
    }
    
    private func configureNextButton() {
        nextButton = Button()
        nextButton.bind( buttonLabelText: "HomeViewController.ButtonTitle".localized,
                         font: UIFont(name: "Hind-Bold", size: 16) ?? UIFont(),
                         textColor: .white)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        view.addSubview(nextButton)
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(verificationCodeTextfield.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.height.equalTo(50)
        }
    }

    private func saveData() {
        do {
            try KeychainManager.shared.save(account: self.phoneNumber ?? "",
                                     password: self.password?.data(using: .utf8) ?? Data())
        } catch {
            print(error)
        }
    }
    
    @objc private func nextButtonTapped() {
        if verificationCodeTextfield.text?.isEmpty == false {
            incorrectPasswordLabel.isHidden = true
            timer?.invalidate()

            self.saveData()

            presenter.nextButtonTapped(phoneNumber: self.phoneNumber ?? "")
            UserDefaults.standard.setValue(true, forKey: "homeWireFrameShown")
            print("Registration was successful")
        } else {
            incorrectPasswordLabel.isHidden = false
            print("Registration was unsuccessful")
        }
    }
    
    private func configureStackView() {
        stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(nextButton.snp.bottom).offset(15)
            make.leading.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureIncorrectPassword() {
        incorrectPasswordLabel = UILabel()
        incorrectPasswordLabel.text = "LoginViewController.IncorrectPassword".localized
        incorrectPasswordLabel.textAlignment = .center
        incorrectPasswordLabel.textColor = Colors.incorrectPassword
        incorrectPasswordLabel.numberOfLines = 2
        incorrectPasswordLabel.isHidden = true
        incorrectPasswordLabel.font = UIFont(name: "Hind-Regular", size: 16)
        
        stackView.addArrangedSubview(incorrectPasswordLabel)
        
        incorrectPasswordLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureSendAgainButton() {
        sendAgainButton = AttributedCustomButton(title: "VerificationViewController.CodeResend".localized, subtitle: " (\(seconds)s)")
        sendAgainButton.backgroundColor = .clear
        sendAgainButton.isEnabled = false
        
        timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector:#selector(configureTimer), userInfo: nil, repeats: true)
        sendAgainButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        stackView.addArrangedSubview(sendAgainButton)
        
        sendAgainButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func startTimer() {
        if seconds == 5 {
            timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector:#selector(configureTimer), userInfo: nil, repeats: true)
            sendAgainButton.isEnabled = false
        } else {
            return
        }
    }
    
    @objc private func configureTimer() {
        seconds -= 1
        sendAgainButton.bind(title: "VerificationViewController.CodeResend".localized, subTitle:" (\(seconds)s)", buttonType: seconds == 0 ? .enabled : .disabled)
        
        if seconds == 0 {
            timer?.invalidate()
            sendAgainButton.bind(title: "VerificationViewController.CodeResend".localized, subTitle:"", buttonType: seconds == 0 ? .enabled : .disabled)
            seconds = 5
        } else {
            sendAgainButton.isEnabled = true
        }
    }
    
    private func configureChangePhoneNumberButton() {
        changePhoneNumberButton = UIButton()
        changePhoneNumberButton.addTarget(self, action: #selector(changePhoneNumberButtonTapped), for: .touchUpInside)
        
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont(name: "Hind-Regular", size: 16) ?? UIFont(),
            NSAttributedString.Key.foregroundColor: UIColor.blue,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        changePhoneNumberButton.tintColor = Colors.button
        let attributeString = NSMutableAttributedString(
            string: "VerificationViewController.ChangePhoneNumber".localized,
            attributes: attributes
        )
        changePhoneNumberButton.backgroundColor = .clear
        changePhoneNumberButton.setAttributedTitle(attributeString, for: .normal)
        stackView.addArrangedSubview(changePhoneNumberButton)
        
        changePhoneNumberButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func changePhoneNumberButtonTapped() {
        presenter.changePhoneNumberButtonTapped()
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

// MARK: - Extensions -

extension VerificationViewController: VerificationViewInterface {
    func pushPhoneNumber(phoneNumber: String) {
        self.phoneNumber = phoneNumber
        
        let numberAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Hind-Bold", size: 15),
            NSAttributedString.Key.foregroundColor: Colors.blackLabel
        ]
        let attributedPhoneNumber = NSMutableAttributedString(string: "\(phoneNumber)",
                                                              attributes: numberAttributes as [NSAttributedString.Key : Any])
        
        let attributes = [
            NSAttributedString.Key.font: UIFont(name: "Hind-Regular", size: 15),
            NSAttributedString.Key.foregroundColor: Colors.blackLabel
        ]
        let attributedString = NSMutableAttributedString(string: "VerificationViewController.DescriptionLabel".localized,
                                                         attributes: attributes as [NSAttributedString.Key : Any])
        
        let combination = NSMutableAttributedString()
        
        combination.append(attributedString)
        combination.append(attributedPhoneNumber)
        
        descriptionLabel.attributedText = combination
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
    
}

extension VerificationViewController: LoginTextFieldDelegate {
    func textfieldValueDidChange(text: String) {
        let text = verificationCodeTextfield.text ?? ""
        incorrectPasswordLabel.isHidden = true
        presenter.inputChanged(text: text)
        self.password = text
    }
}

extension VerificationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 12
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}
