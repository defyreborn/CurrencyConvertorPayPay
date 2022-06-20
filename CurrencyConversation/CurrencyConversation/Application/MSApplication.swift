//
//  MSApplication.swift
//  CurrencyConversation
//
//  Created by Mubashshir on 6/19/22.
//

import Foundation

class MSApplication {
    var reachability = Reachability()!
    
    init() { }
    
    static var shared: MSApplication = {
        let sharedVar = MSApplication()
        return sharedVar
    }()
    
    private func internetConnectionCheck() {
        reachability.whenReachable = { reachability in
            DispatchQueue.main.async {
                plog("Reachable via internet")
            }
        }
        reachability.whenUnreachable = { reachability in
            DispatchQueue.main.async {
                plog("Not reachable")
            }
        }
        do {
            try reachability.startNotifier()
        } catch {
            plog("Unable to start notifier")
        }
    }
}
