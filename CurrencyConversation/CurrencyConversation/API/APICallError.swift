//
//  APICallError.swift
//  CurrencyConversation
//
//  Created by Mubashshir on 6/19/22.
//

import Foundation


enum APICallStatus: Error {
    
    case success
    case failed
    case forbidden
    case serializationFailed
    case offline
    case timeout
    case unknown
}

class APICallError {
    var critical: Bool = false
    var reason:String = String()
    var message: String = String()
    var callStatus: APICallStatus = .unknown
    var error_type: String = String()
    var error: JSON?
    
    init() {}
    
    init(critical: Bool, reason: String, message: String, callStatus: APICallStatus = .unknown) {
        self.critical = critical
        self.reason = reason
        self.message = message
        self.callStatus = callStatus
    }
    
    convenience init(_ aDict : JSON) {
        self.init(critical: false, reason: aDict["description"].stringValue, message: aDict["message"].stringValue)
    }
    
    convenience init(status:APICallStatus) {
        switch status {
        case .success:
            self.init()
        case .failed:
            self.init(critical: false, reason: "Generic Error, status code isn't 200.", message: NSLocalizedString("Generic Error", comment: ""))
        case .forbidden:
            self.init(critical: false, reason: "HTTP status code 403", message: NSLocalizedString("HTTP status code 403", comment: ""))
        case .serializationFailed:
            self.init(critical: false, reason: "Could not parse the json", message: NSLocalizedString("Could not parse the json", comment: ""))
        case .offline:
            self.init(critical: false, reason: "User offline", message: NSLocalizedString("Internet connection appears to be offline.", comment: ""), callStatus: .offline)
        case .timeout:
            self.init(critical: false, reason: "Slow internet connection", message: NSLocalizedString("Slow internet connection", comment: ""))
        case .unknown:
            self.init(critical: false, reason: "Unknown error", message: NSLocalizedString("Unknown error", comment: ""))
        }
    }
}
