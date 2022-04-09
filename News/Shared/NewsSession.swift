//
//  NewsSession.swift
//  News
//
//  Created by Anbusekar Murugesan on 05/04/2022.
//

import Foundation
import Alamofire


// Api keys
let apiKey = "cd4dc5ee32044e438a7d79d26d49a82b"


// base URL
let baseUrl = "https://newsapi.org/v2/"

class NewsAlamofire: NSObject {
    
    static let sharedInstance = NewsAlamofire()
    
    static var httpHeaders: HTTPHeaders = [:]
    private var manager: Session = Alamofire.Session.default
    
    class func requestFromServer(url: URL, httpMethod: HTTPMethod, parameters: [String: Any]?, encoding: ParameterEncoding, headers: HTTPHeaders?, successBlock: @escaping (_ withResponse: AFDataResponse<Any>?, _ status: Bool?) -> Void, failureBlock: @escaping (_ withError: AFError?, _ cancelStatus: Bool?) -> Void) -> Request {
        func processResponse(_ dataResponse: AFDataResponse<Any>) {
            print(dataResponse)
            
            if dataResponse.error == nil {
                successBlock(dataResponse, true)
                
            } else {//Failure
                //To validate failureblock: pass response and a tuple constructed from            }
                failureBlock(dataResponse.error, false)
            }
        }
        
        return NewsAlamofire.sharedInstance.manager.request(url, method: httpMethod, parameters: parameters, encoding: encoding, headers: headers).validate().responseJSON { (dataResponse) in
            processResponse(dataResponse)
        }
        
    }
    
    
    // MARK: - Request Methods
    
    class func getRequest(url: URL, parameters: [String: Any]?, successBlock: @escaping (_ withResponse: AFDataResponse<Any>?, _ status: Bool?) -> Void, failureBlock: @escaping (_ withError: AFError?, _ cancelStatus: Bool?) -> Void) -> Request {
        return requestFromServer(url: url, httpMethod: .get, parameters: parameters, encoding: JSONEncoding.default, headers: nil, successBlock: successBlock, failureBlock: failureBlock)
    }


}
