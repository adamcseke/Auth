//
//  WrongPinCodeAlertViewController.swift
//  Auth
//
//  Created by Adam Cseke on 2022. 02. 23..
//  Copyright © 2022. levivig. All rights reserved.
//

import UIKit

class WrongPinCodeAlertViewController: UIViewController {
    
    private var containerView: UIView!
    private var titleLabel: UILabel!
    private var messageLabel: UILabel!
    private var actionButton: Button!
    private var buttonLabel: UILabel!
    
    var alertTitle: String?
    var message: String?
    
    init(title: String, message: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if ((touch?.view) != nil) {
            dismiss(animated: true)
        }
    }
    
    private func setup() {
        configureViewController()
        configureContainerView()
        configureTitleLabel()
        configureMessageLabel()
        configureActionButton()
        configureButtonLabel()
    }
    
    private func configureViewController() {
        view.backgroundColor = .black.withAlphaComponent(0.75)
    }
    
    private func configureContainerView() {
        containerView = UIStackView()
        containerView.layer.cornerRadius = 16
        containerView.backgroundColor = Colors.background
        view.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func configureTitleLabel() {
        titleLabel = UILabel()
        titleLabel.textColor = Colors.blackLabel
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.text = alertTitle ?? ""
        containerView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(28)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureMessageLabel() {
        messageLabel = UILabel()
        messageLabel.numberOfLines = 4
        messageLabel.textAlignment = .center
        messageLabel.textColor = Colors.placeholder
        messageLabel.text = message ?? ""
        messageLabel.font = .systemFont(ofSize: 14, weight: .regular)
        containerView.addSubview(messageLabel)
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(26)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureActionButton() {
        actionButton = Button()
        actionButton.backgroundColor = Colors.button
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        containerView.addSubview(actionButton)
        
        actionButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
    }
    
    private func configureButtonLabel() {
        buttonLabel = UILabel()
        
        buttonLabel.textColor = .white
        buttonLabel.font = .systemFont(ofSize: 20)
        buttonLabel.textAlignment = .center
        buttonLabel.font = .systemFont(ofSize: 20, weight: .bold)
        actionButton.addSubview(buttonLabel)
        
        buttonLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
}
