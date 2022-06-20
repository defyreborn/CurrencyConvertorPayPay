//
//  AppDelegate.swift
//  CurrencyConversation
//
//  Created by Mubashshir on 6/14/22.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Utill.prepareApplication(application: application)
        
        return true
    }
}

