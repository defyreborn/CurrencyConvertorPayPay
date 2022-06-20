//
//  ExchangeRatesModel.swift
//  CurrencyConversation
//
//  Created by Mubashshir on 6/17/22.
//

import Foundation

class ExchangeRatesModel : NSObject {

    var currencyName            : String = ""
    var country                 : String = ""
    var symbol                  : String = ""
    var rate                    : Double = 0.0
    
    init(currenyName : String, country : String, rate : Double,symbol : String) {
        self.currencyName = currenyName
        self.country      = country
        self.symbol       = symbol
        self.rate         = rate
    }
    
    init(aDict : JSON) {
        let currencyAbb = aDict["rates"].dictionaryValue.keys
        for key in currencyAbb {
            self.currencyName = key
            self.rate = aDict["rates"][key].doubleValue
            self.symbol = key
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

