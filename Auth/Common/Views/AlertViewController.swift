//
//  AlertViewController.swift
//  Auth
//
//  Created by Adam Cseke on 2022. 02. 23..
//  Copyright © 2022. levivig. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {
    
    private var containerView: UIView!
    private var imageView: UIImageView!
    private var titleLabel: UILabel!
    private var messageLabel: UILabel!
    private var actionButton: Button!
    private var buttonLabel: UILabel!
    
    var alertTitle: String?
    var message: String?
    var buttonText: String?
    var alertImage: UIImage?
    
    init(title: String, message: String, buttonLabel: String, alertImage: UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonText = buttonLabel
        self.alertImage = alertImage
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
        configureImageView()
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
            make.leading.equalToSuperview().offset(16)
        }
    }
    
    private func configureImageView() {
        imageView = UIImageView()
        imageView.image = alertImage
        imageView.image?.withTintColor(Colors.button)
        imageView.layer.masksToBounds = true
        containerView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(65)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
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
            make.top.equalTo(imageView.snp.bottom).offset(29)
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
            make.bottom.equalToSuperview().offset(-64)
            make.height.equalTo(44)
        }
    }
    
    private func configureButtonLabel() {
        buttonLabel = UILabel()
        buttonLabel.text = buttonText
        buttonLabel.textColor = .white
        buttonLabel.font = UIFont(name: "Hind-Bold", size: 20)
        buttonLabel.textAlignment = .center
        actionButton.addSubview(buttonLabel)
        
        buttonLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
}
