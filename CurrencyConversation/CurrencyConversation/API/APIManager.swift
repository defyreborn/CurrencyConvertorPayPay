//
//  APIManager.swift
//  CurrencyConversation
//
//  Created by Mubashshir on 6/19/22.
//

import Foundation
import Alamofire


class APIManager {
    static let shared : APIManager = {
        let instance = APIManager()
        return instance
    }()
    
    let sessionManager : Session
    
    private init() {
        let config = URLSessionConfiguration.default
        config.urlCache = nil
        config.timeoutIntervalForRequest = 600
        config.timeoutIntervalForResource = 600
        
        sessionManager = Session.init(configuration: config)
    }
    
    func callRequest(_ router: APIRouter, onSuccess success: @escaping (_ response : JSON) -> Void, onFailure failure : @escaping (_ error: APICallError) -> Void) {
        
        guard MApplication.reachability.isReachable == true else{
            let apiError = APICallError(status: .offline)
            failure(apiError)
            return
        }
        
        var reqUrl = URL(string: "\(MEnviornment.APIBasePath())/\(router.endPoint)?app_id=\(MEnviornment.openExchangeAppID())")
        
        switch router {
        case .latest:
            reqUrl = URL(string: "\(MEnviornment.APIBasePath())/\(router.endPoint)?app_id=\(MEnviornment.openExchangeAppID())&base=\(router.parameters?["base"] ?? "")")
        case .currencies:
            break
        }
        

        self.sessionManager.requestForCC(reqUrl!, method: router.method, parameters: nil, encoding: URLEncoding.httpBody, headers: nil).responseJSON { response in
            switch response.result {
            case .success(let value) :
                let json = JSON(value)
                if json["error"].boolValue == true {
                    let apiError = APICallError.init(json)
                    failure(apiError)
                } else {
                    success(json)
                }
            case .failure(let error):
                let apiError = APICallError(status: .failed)
                apiError.message = error.localizedDescription
                failure(apiError)
            }
        }
        
    }
}


extension Session {
    public func requestForCC(
        _ url       : URLConvertible,
        method      : HTTPMethod = .get,
        parameters  : Parameters? = nil,
        encoding    : ParameterEncoding = URLEncoding.default,
        headers      : HTTPHeaders? = nil) -> DataRequest {
            
            let param = parameters ?? [:]
            let string = String(describing: JSON(param)).replacingOccurrences(of: "\n", with: "")
            let jsonParam : Parameters = ["json_string" : string]
            
            var _headers = headers
            
            return Session.default.request(url,method: method,parameters: parameters, encoding: encoding, headers: _headers)
        }
}
