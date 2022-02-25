//
//  CountriesTableViewCell.swift
//  Auth
//
//  Created by Adam Cseke on 2022. 02. 22..
//  Copyright © 2022. levivig. All rights reserved.
//

import UIKit

class CountriesTableViewCell: UITableViewCell {

    static let reuseID = "CountriesCell"
    
    private var countryFlagLabel: UILabel!
    private var countryLabel: UILabel!
    private var countryNumberLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func set(countryFlag: String, countryText: String, countryNumber: String) {
        countryFlagLabel.text = countryFlag
        countryLabel.text = countryText
        countryNumberLabel.text = countryNumber
    }
    
    private func configure() {
        countryFlagLabel = UILabel()
        countryLabel = UILabel()
        countryNumberLabel = UILabel()
        addSubview(countryFlagLabel)
        addSubview(countryLabel)
        addSubview(countryNumberLabel)
        
        countryLabel.font = UIFont(name: "Hind-Bold", size: 15)
        countryNumberLabel.font = UIFont(name: "Hind-Regular", size: 15)
        
        countryFlagLabel.layer.cornerRadius = 12
        countryFlagLabel.layer.masksToBounds = true

        accessoryType = .disclosureIndicator
        
        countryFlagLabel.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerY.equalTo(snp.centerY)
            make.leading.equalTo(21)
        }
        
        countryLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.leading.equalTo(countryFlagLabel.snp.trailing).offset(20)
        }
        
        countryNumberLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.leading.equalTo(countryLabel.snp.trailing).offset(35)
        }
    }
    
}
