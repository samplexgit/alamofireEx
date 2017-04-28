//
//  URLSessionViewController.swift
//  AFNetworking
//
//  Created by Shilp_m on 4/26/17.
//  Copyright © 2017 Shilp_mphoton pho. All rights reserved.
//

import UIKit

protocol returnDelegate {
    func returnData(data: NSDictionary)
}

class URLSessionManager: NSObject {

    static let  SharedInstance = URLSessionManager()
    var result: NSDictionary = [:]
    var delegatePro: returnDelegate!
    
    override init() {
        super.init()
        
    }
    
    func RequestManger(urlString: String)-> NSDictionary {
        // Show MBProgressHUD Here
        var config                              :URLSessionConfiguration!
        var urlSession                          :URLSession!
        
        config = URLSessionConfiguration.default
        urlSession = URLSession(configuration: config)
        
        // MARK:- HeaderField
        let HTTPHeaderField_ContentType         = "Content-Type"
        
        // MARK:- ContentType
        let ContentType_ApplicationJson         = "application/json"
        
        //MARK: HTTPMethod
        let HTTPMethod_Get                      = "PUT"
        
        let callURL = URL.init(string: urlString)
        
        var request = URLRequest.init(url: callURL!)
        
        request.timeoutInterval = 60.0 // TimeoutInterval in Second
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        request.addValue(ContentType_ApplicationJson, forHTTPHeaderField: HTTPHeaderField_ContentType)
        request.httpMethod = HTTPMethod_Get
        
        let dataTask = urlSession.dataTask(with: request) { (data,response,error) in
            if error != nil{
                return
            }
            do {
                let resultJson = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]
                print("Result",resultJson!)
                self.result = resultJson! as NSDictionary
                self.delegatePro.returnData(data: self.result)
                
                
            } catch {
                print("Error -> \(error)")
            }
        }
        
        dataTask.resume()
        return self.result
    }
    
    
}

