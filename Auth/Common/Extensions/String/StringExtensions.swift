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
        let data = self.data(using: .utf8)!
        let decoderStr = NSString(data: data, encoding: String.Encoding.nonLossyASCII.rawValue)
        if let str = decoderStr {
            return str as String
        }
        return self
    }

    var encodeEmoji: String {
        if let encodeStr = NSString(cString: self.cString(using: .nonLossyASCII)!, encoding: String.Encoding.utf8.rawValue) {
            return encodeStr as String
        }
        return self
    }


}
