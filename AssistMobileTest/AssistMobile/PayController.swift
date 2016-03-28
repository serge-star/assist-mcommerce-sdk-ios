//
//  PayController.swift
//  AssistPayTest
//
//  Created by Sergey Kulikov on 29.06.15.
//  Copyright (c) 2015 Assist. All rights reserved.
//

import UIKit

class PayController: UIViewController, UIWebViewDelegate, NSURLConnectionDataDelegate, RegistrationDelegate, DeviceLocationDelegate, ResultServiceDelegate {
    
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var wait: UIActivityIndicatorView!
    
    var authenticated = false
    var locationUpdated = false
    var registrationCompleted = false
    var urlConnection: NSURLConnection?
    var badRequest: NSURLRequest?
    var data: PayData?
    var deviceLocation: DeviceLocation?
    weak var payDelegate: AssistPayDelegate?
    var repeated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wait.startAnimating()
        
        if let params = data {
            collectDeviceData(params)
            
            if let regId = Configuration.regId {
                params.registrationId = regId
                registrationCompleted = true
                continuePay()
            } else {
                startRegistration()
            }
        }
    }
    
    func collectDeviceData(data: PayData) {
        data.deviceUniqueId = Configuration.uuid
        data.device = Configuration.model
        data.applicationName = Configuration.appName
        data.applicationVersion = Configuration.version
        data.osLanguage = Configuration.preferredLang
        
        deviceLocation = DeviceLocation(delegate: self)
        deviceLocation!.requestLocation()
    }
    
    func startRegistration() {
        let regData = RegistrationData()
        
        regData.name = Configuration.appName
        regData.version = Configuration.version
        regData.deviceId = Configuration.uuid
        regData.shop = data?.merchantId
        let reg = Registration(regData: regData, regDelegate: self)
        reg.start()
    }
    
    func startPayment(params: PayData) {
        print("start payment")
        let request = params.buldRequest(NSURL(string: AssistLinks.currentHost + AssistLinks.PayPagesService)!)
        
        webView.delegate = self
        webView.loadRequest(request)
    }
    
    func continuePay() {
        print("continue payment loc = \(locationUpdated), reg = \(registrationCompleted)")
        if locationUpdated && registrationCompleted {
            startPayment(data!)
        }
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        wait.stopAnimating()
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        request.URL?.description
        print("WebView delegate");
        
        if let url = request.URL {
            print("URL: \(url.path)")
            
            if let path = url.path {
                if path.hasSuffix("result.cfm") {
                    webView.stopLoading()
                    getResult()
                } else if path.hasSuffix("body.cfm") {
                    webView.stopLoading()
                    repeated = true
                    getResult()
                }
            }
        }
        
        if !authenticated {
            badRequest = request
            urlConnection = NSURLConnection(request: NSURLRequest(URL: request.URL!), delegate: self)
            urlConnection?.start()
            
            return false
        }
        
        return true
    }
    
    func connection(connection: NSURLConnection, willSendRequestForAuthenticationChallenge challenge: NSURLAuthenticationChallenge) {
        
        print("connection willSend")
        
        let method = challenge.protectionSpace.authenticationMethod
        if method == NSURLAuthenticationMethodServerTrust {
            print("trusted host")
            if let trust = challenge.protectionSpace.serverTrust {
                challenge.sender?.useCredential(NSURLCredential(forTrust: trust), forAuthenticationChallenge: challenge)
            }
        } else {
            print("not trusted host")
        }
        
        challenge.sender?.continueWithoutCredentialForAuthenticationChallenge(challenge)
    }
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        print("connection didReceiveResponse")
        authenticated = true
        connection.cancel()
        webView.loadRequest(badRequest!)
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        print("connection didFailWithError description: \(error.description)")
        repeated = true
        getResult()
    }
    
    func registration(id: String) {
        print("registration: get id")
        if let params = data {
            params.registrationId = id
            Configuration.regId = id
            registrationCompleted = true
            continuePay()
        }
    }
    
    func registration(faultcode: String?, faultstring: String?) {
        print("registration: error faultcode=\(faultcode), faultstring=\(faultstring)")
        resultError(faultcode, faultstring: faultstring)
    }
    
    func location(latitude: String, longitude: String) {
        print("location updated")
        if !locationUpdated {
            data!.latitude = latitude
            data!.longitude = longitude
            locationUpdated = true
            continuePay()
        }
    }
    
    func locationError(text: String) {
        if !locationUpdated {
            print("location error: \(text)")
            locationUpdated = true
            continuePay()
        }
    }
    
    func getResult() {
        let request = ResultRequest()
        if let payData = data {
            request.deviceId = Configuration.uuid
            request.regId = Configuration.regId
            request.orderNo = payData.orderNumber
            request.merchantId = payData.merchantId
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let date = payData.date ?? NSDate()
            request.date = dateFormatter.stringFromDate(date)
            let service = ResultService(requestData: request, delegate: self)
            service.start()
        }
    }
    
    func result(bill: String, state: String, message: String?) {
        print("success: bill=\(bill), state=\(state), message=\(message)")
        dispatch_async(dispatch_get_main_queue()) { [unowned self] in
            self.dismissViewControllerAnimated(true, completion: nil)
            
            if let delegate = self.payDelegate {
                var status = PaymentStatus(rawValue: state) ?? .Unknown
                if self.repeated {
                    status = .Repeated
                }
                
                delegate.payFinished(bill, status: status.rawValue, message: message)
            }
        }
    }
    
    func resultError(faultcode: String?, faultstring: String?) {
        
        dispatch_async(dispatch_get_main_queue()) { [unowned self] in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
            if let delegate = self.payDelegate {
                var errorMessage = "Error:"
                if let code = faultcode, string = faultstring {
                    errorMessage += " faultcode = \(code), faultstring = \(string)";
                } else {
                    errorMessage += " unknown"
                }
                
                delegate.payFinished("", status: "Unknown", message: errorMessage)
            }
        }
    }
    
    var payData: PayData? {
        get {
            return data
        }
        set {
            data = newValue
        }
    }
    
}
