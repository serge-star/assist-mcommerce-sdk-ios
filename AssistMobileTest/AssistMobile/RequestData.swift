//
//  RequestData.swift
//  AssistPayTest
//
//  Created by Sergey Kulikov on 02.07.15.
//  Copyright (c) 2015 Assist. All rights reserved.
//

import Foundation

public class RequestData: NSObject {
    func buildRequestString() -> String {
        return ""  // it must be overriden
    }
    
    func addHeaderProperties(request: NSMutableURLRequest) {
        // override if want add properties
    }
    
    func buldRequest(url: NSURL) -> NSURLRequest {
        let contents = buildRequestString()
        let body = NSMutableData()
        body.appendData(contents.dataUsingEncoding(NSUTF8StringEncoding)!)
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        
        addHeaderProperties(request)
        
        let contentLength = "\(body.length)"
        request.setValue(contentLength, forHTTPHeaderField: "Content-Length")
        request.HTTPBody = body
        
        print("request body \(body), contents \(contents)")
        
        return request
    }
}