//
//  RequestData.swift
//  AssistPayTest
//
//  Created by Sergey Kulikov on 02.07.15.
//  Copyright (c) 2015 Assist. All rights reserved.
//

import Foundation

open class RequestData: NSObject {
    func buildRequestString() -> String {
        return ""  // it must be overriden
    }
    
    func addHeaderProperties(_ request: NSMutableURLRequest) {
        // override if want add properties
    }
    
    func buldRequest(_ url: URL) -> URLRequest {
        let contents = buildRequestString()
        let body = NSMutableData()
        body.append(contents.data(using: String.Encoding.utf8)!)
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        
        addHeaderProperties(request)
        
        let contentLength = "\(body.length)"
        request.setValue(contentLength, forHTTPHeaderField: "Content-Length")
        request.httpBody = body as Data
        
        print("request body \(body), contents \(contents)")
        
        return request as URLRequest
    }
}
