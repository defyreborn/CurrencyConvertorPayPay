//
//  MEnviornment.swift
//  CurrencyConversation
//
//  Created by Mubashshir on 6/19/22.
//

import Foundation


class MEnviornment {
    
    enum Enviornment : String {
        case dev
        case test
        case prod
        case uat
    }
    
    enum BasePathEnum : String { case openExchangeRates = "openexchangerates.org/api"}
    
    //Use when different enviornment setup.

    static let env : Enviornment = .prod
    
    static let basePath : BasePathEnum = .openExchangeRates
    
    class func APIBasePath() -> String {
        return "https://\(basePath.rawValue)"
    }
    
    class func openExchangeAppID() -> String {
        switch env {
        default : return "16d08e370d9f45e486344afe1082f289"
        }
    }
    
}
