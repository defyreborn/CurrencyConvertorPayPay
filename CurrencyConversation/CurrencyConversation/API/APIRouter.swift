//
//  APIRouter.swift
//  CurrencyConversation
//
//  Created by Mubashshir on 6/19/22.
//

import Foundation
import Alamofire

typealias APIParams = [String: Any]?

enum APIRouter {
    
    case latest(APIParams)
    case currencies
    
    var endPoint : String {
        switch self {
        case .latest : return "latest.json"
        case .currencies : return "currencies.json"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .latest : return .get
        case .currencies : return .get
        default :
            return .post
        }
    }
    
    var parameters : [String : Any]? {
        switch self {
        case .latest(let param):
        return param
        default : return [:]
        }
    }
}
