//
//  ApplePayService.swift
//  AssistMobileTest
//
//  Created by Sergey Kulikov on 27.12.16.
//  Copyright © 2016 Assist. All rights reserved.
//

import Foundation
import PassKit

class ApplePayService: NSObject, URLSessionDelegate {
    
    fileprivate var data: PayData
    fileprivate var delegate: AssistPayDelegate
    fileprivate var completion: (PKPaymentAuthorizationStatus) -> Void
    
    init(requestData: PayData, delegate: AssistPayDelegate, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        data = requestData
        self.delegate = delegate
        self.completion = completion
    }
    
    func start() {
        run(data)
    }
    
    func getUrl() -> String {
        return AssistLinks.currentHost + AssistLinks.ApplePayService
    }
    
    fileprivate func run(_ request: PayData) {
        let requestData = request.buldRequest(URL(string: getUrl())!)
        
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: nil)
        
        let task = session.dataTask(with: requestData) { sessionData, response, error in
            guard let sessionData = sessionData, error == nil else {
                DispatchQueue.main.async {
                    self.completion(PKPaymentAuthorizationStatus.failure)
                    self.delegate.payFinished("", status: "Unknown", message: error as! String?)
                }
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                DispatchQueue.main.async {
                    self.delegate.payFinished("", status: "Unknown", message: "Bad status code: \(httpStatus.statusCode)")
                    self.completion(PKPaymentAuthorizationStatus.failure)
                }
            }
            
            var status = PKPaymentAuthorizationStatus.failure
            var paymentStatus = "Unknown"
            var message = "Can not get result"
            var billnumber = ""
            
            let json = try? JSONSerialization.jsonObject(with: sessionData) as? [String:Any]
            if let orders = json??["order"] as? [Any] {
                if let order = orders[0] as? [String:Any] {
                    if let operations = order["operations"] as? [Any] {
                        if let operation = operations[0] as? [String:Any] {
                            message = operation["message"] as? String ?? ""
                        }
                    }
                    paymentStatus = order["orderstate"] as? String ?? "Unknown"
                    billnumber = order["billnumber"] as? String ?? ""
                }
            } else {
                if let firstcode = json??["firstcode"] as? Int {
                    let secondcode = json??["secondcode"] as? Int
                    message = "firstcode: \(firstcode), secondcode: \(secondcode)"
                }
            }
            
            if paymentStatus == "Approved" {
                status = PKPaymentAuthorizationStatus.success
            }
            
            DispatchQueue.main.async {
                self.completion(status)
                self.delegate.payFinished(billnumber, status: paymentStatus, message: message)
            }
        }
        
        task.resume()
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}
