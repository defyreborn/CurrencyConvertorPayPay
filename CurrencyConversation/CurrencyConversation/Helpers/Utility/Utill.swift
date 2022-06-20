//
//  Utill.swift
//  CurrencyConversation
//
//  Created by Mubashshir on 6/15/22.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift
import SVProgressHUD

class Utill: NSObject {
    
    class func prepareApplication(application : UIApplication) {
        application.statusBarStyle                      = .lightContent
        IQKeyboardManager.shared.enable                 = true
        IQKeyboardManager.shared.toolbarTintColor       = .black
    }
    
    class func showProgressHud(_ presentedView : UIView? = nil) {
        DispatchQueue.main.async {
            SVProgressHUD.show()
        }
    }
    
    class func hideProgressHud(_ presentedView: UIView? = nil) {
        DispatchQueue.main.async{
            SVProgressHUD.dismiss()
        }
    }
    
    class func getSymbol(forCurrencyCode code: String) -> String? {
        let locale = NSLocale(localeIdentifier: code)
        if locale.displayName(forKey: .currencySymbol, value: code) == code {
            let newLocale = NSLocale(localeIdentifier: code.dropLast() + "_en")
            return newLocale.displayName(forKey: .currencySymbol, value: code)
        }
        return locale.displayName(forKey: .currencySymbol, value: code)
    }
    
}
    
