//
//  CurrenciesModel.swift
//  CurrencyConversation
//
//  Created by Mubashshir on 6/20/22.
//

import Foundation


class CurrenciesModel : NSObject {
 
    var currencyName : String = ""
    var countryName : String = ""
    
    init(currencyName : String, countryName : String) {
        self.currencyName = currencyName
        self.countryName = countryName
    }
    
    init(aDict: JSON) {
        for key in aDict.dictionaryValue.keys {
            self.currencyName = key
            self.countryName = aDict[key].stringValue
        }
    }
    
    func getSymbol() -> String? {
        let locale = NSLocale(localeIdentifier: currencyName)
        if locale.displayName(forKey: .currencySymbol, value: currencyName) == currencyName {
            let newLocale = NSLocale(localeIdentifier: currencyName.dropLast() + "_en")
            return newLocale.displayName(forKey: .currencySymbol, value: currencyName)
        }
        return locale.displayName(forKey: .currencySymbol, value: currencyName)
    }
}
