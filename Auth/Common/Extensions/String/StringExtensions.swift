//
//  StringExtensions.swift
//  Auth
//
//  Created by Adam Cseke on 2022. 02. 18..
//  Copyright © 2022. levivig. All rights reserved.
//

import Foundation

extension String {
    /// Localization: Returns a localized string
    ///
    ///        "Hello world".localized -> Hallo Welt
    ///
    public var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    var decodeEmoji: String {
        let data = self.data(using: .utf8) ?? Data()
        let decoderStr = NSString(data: data, encoding: String.Encoding.nonLossyASCII.rawValue)
        if let str = decoderStr {
            return str as String
        }
        return self
    }
    
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}
