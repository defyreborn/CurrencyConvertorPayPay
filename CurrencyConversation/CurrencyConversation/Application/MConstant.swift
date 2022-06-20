//
//  MConstant.swift
//  CurrencyConversation
//
//  Created by Mubashshir on 6/19/22.
//

import Foundation

let MApplication = MSApplication.shared

var AppName                 : String {return Bundle.main.infoDictionary!["CFBundleName"] as! String}
var AppDisplayName          : String {return Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String}

var AppVersion              : String {return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String}

var buildVersion            : String {return Bundle.main.infoDictionary!["CFBundleVersion"] as! String}
