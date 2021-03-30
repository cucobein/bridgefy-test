//
//  String+Regex.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 28/03/21.
//

import Foundation

enum Regex {
    static var email: String {
        """
        ^((\"[\\w-\\s]+\")|([\\w-]+(?:\\.[\\w-]+)*)|(\"[\\w-\\s]+\")\
        ([\\w-]+(?:\\.[\\w-]+)*))(@((?:[\\w-]+\\.)*\\w[\\w-]{0,66})\
        \\.([a-z]{2,7}(?:\\.[a-z]{2})?)$)|(@\\[?((25[0-5]\\.|2[0-4][0-9]\\.|1[0-9]{2}\\.|[0-9]{1,2}\\.))\
        ((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\\]?$)
        """
    }
}

extension String {
    
    func matchesRegex(regex: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count)) != nil
        } catch {
            return false
        }
    }
    
    func languageName() -> String {
        if let name = (Locale.current as NSLocale).displayName(forKey: .languageCode, value: self) {
            return name
        } else {
            return self
        }
    }
    
    func currencyName() -> String? {
        let locale = NSLocale(localeIdentifier: "en_US")
        return locale.displayName(forKey: .currencyCode, value: self)
    }
    
    var isEmail: Bool {
        return matchesRegex(regex: Regex.email)
    }
}
