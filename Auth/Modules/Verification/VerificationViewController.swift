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
    private var verificationCodeTextfield: VerificationCodeTextField!
    private var nextButton: Button!
    private var sendAgainButton: AttributedCustomButton!
    private var secondsLabel: UILabel!
    private var attributeString = NSMutableAttributedString()
    private var changePhoneNumberButton: UIButton!

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
        configureSendAgainButton()
        configureChangePhoneNumberButton()
        self.hideKeyboardWhenTappedAround()
    }
    
    private func configureViewController() {
        view.backgroundColor = Colors.background
    }
    
    private func configureTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "VerificationViewController.TitleLabel".localized
        titleLabel.textColor = Colors.blackLabel
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
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
        descriptionLabel.font = .systemFont(ofSize: 15, weight: .regular)
        view.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configurePinCodeTextfield() {
        verificationCodeTextfield = VerificationCodeTextField()
        verificationCodeTextfield.keyboardType = .numberPad
        verificationCodeTextfield.textColor = .black
        verificationCodeTextfield.font = .systemFont(ofSize: 20, weight: .bold)
        verificationCodeTextfield.customDelegate = self
        verificationCodeTextfield.addTarget(self, action: #selector(textFieldEdidtingDidChange(_ :)), for: UIControl.Event.editingChanged)
        
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold),
            NSAttributedString.Key.foregroundColor: Colors.blackLabel,
            NSAttributedString.Key.kern: CGFloat(5.0)
          ]
        let attributedPlaceholder = NSMutableAttributedString(string: "- - - - - -", attributes: attributes)
        attributedPlaceholder.addAttribute(NSAttributedString.Key.kern, value: CGFloat(5.0), range: NSRange(location: 0, length: attributedPlaceholder.length))
        verificationCodeTextfield.attributedPlaceholder = attributedPlaceholder
        
        view.addSubview(verificationCodeTextfield)

        verificationCodeTextfield.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.height.equalTo(50)
        }
    }
    
    @objc func textFieldEdidtingDidChange(_ textField :UITextField) {
        let attributedString = NSMutableAttributedString(string: verificationCodeTextfield.text ?? "")
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(8.0), range: NSRange(location: 0, length: attributedString.length))
        verificationCodeTextfield.attributedText = attributedString
    }
    
    private func configureNextButton() {
        nextButton = Button()
        nextButton.bind( buttonLabelText: "HomeViewController.ButtonTitle".localized,
                        font: .systemFont(ofSize: 16, weight: .bold),
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
    
    @objc
    private func nextButtonTapped() {
        print("button tapped")
    }
    
    private func configureSendAgainButton() {
        sendAgainButton = AttributedCustomButton(title: "VerificationViewController.CodeResend".localized, subtitle: " (\(seconds)s)")
        sendAgainButton.backgroundColor = .clear
        sendAgainButton.isEnabled = false

        timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector:#selector(configureTimer), userInfo: nil, repeats: true)
        sendAgainButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        view.addSubview(sendAgainButton)
        
        sendAgainButton.snp.makeConstraints { make in
            make.top.equalTo(nextButton.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func startTimer() {
        print("button tapped")
        timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector:#selector(configureTimer), userInfo: nil, repeats: true)
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
        print("This is a second ", seconds)
    }
    
    private func configureChangePhoneNumberButton() {
        changePhoneNumberButton = UIButton()
        
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
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
        view.addSubview(changePhoneNumberButton)
        
        changePhoneNumberButton.snp.makeConstraints { make in
            make.top.equalTo(sendAgainButton.snp.bottom).offset(13)
            make.leading.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
        }
    }
    
}

// MARK: - Extensions -

extension VerificationViewController: VerificationViewInterface {
    func pushPhoneNumber(phoneNumber: String) {
        descriptionLabel.text = "VerificationViewController.DescriptionLabel".localized + "\(phoneNumber)"
    }
    
    func setButton(enable: Bool) {
        if !enable {
            nextButton.isEnabled = false
            nextButton.backgroundColor = Colors.button.withAlphaComponent(0.5)
        } else {
            nextButton.isEnabled = true
            nextButton.backgroundColor = Colors.button
        }
    }
    
}

extension VerificationViewController: VerificationCodeTextfieldDelegate {
    func textfieldValueDidChange(text: String) {
        let text = verificationCodeTextfield.text ?? ""
        presenter.inputChanged(text: text)
        print(text)
    }
}
