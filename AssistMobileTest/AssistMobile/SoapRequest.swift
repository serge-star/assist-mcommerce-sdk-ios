//
//  SoapRequest.swift
//  AssistPayTest
//
//  Created by Sergey Kulikov on 16.07.15.
//  Copyright (c) 2015 Assist. All rights reserved.
//

import Foundation

class SoapRequest: RequestData {
    var data = [String:String]()
    let soapAction: String
    
    init(soapAction: String) {
        self.soapAction = soapAction
    }
    
    func buildRequestHeader() -> String {
        return String()  // must be overriden
    }
    
    func buildRequestTail() -> String {
        return String() // must be overriden
    }
    
    override func buildRequestString() -> String {
        var request = buildRequestHeader()
        
        for (key, value) in data {
            request += "<\(key)>\(value)</\(key)>\n"
        }
        
        request += buildRequestTail()
        
        return request
    }
    
    override func addHeaderProperties(request: NSMutableURLRequest) {
        request.setValue("text/xml", forHTTPHeaderField: "Content-Type")
        request.setValue("UTF-8", forHTTPHeaderField: "Content-Encoding")
        request.setValue(soapAction, forHTTPHeaderField: "SOAPAction")
    }
    
}

class SoapService: NSObject, NSURLConnectionDataDelegate, NSXMLParserDelegate {
    let faultcode = ".soapenv:Envelope.soapenv:Body.soapenv:Fault.faultcode"
    let faultstring = ".soapenv:Envelope.soapenv:Body.soapenv:Fault.faultstring"
    
    private var responseData = NSMutableData()
    private var currentElement = String()
    private var values = [String:String]()
    private var names = [String]()
    
    func getUrl() -> String {
        return String() // must be overriden
    }
    
    func clean() {
        responseData = NSMutableData()
        values = [String:String]()
    }
    
    func run(request: SoapRequest) {
        let requestData = request.buldRequest(NSURL(string: getUrl())!)
        
        if let connect = NSURLConnection(request: requestData, delegate: self) {
            clean()
            connect.start()
        }
    }
    
    func getElementName() -> String {
        return names.reduce("") {$0 + "." + $1}
    }
    
    func connection(connection: NSURLConnection, willSendRequestForAuthenticationChallenge challenge: NSURLAuthenticationChallenge) {
        print("Connection: will send auth")
        
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
        print("Connection: response loaded \(response)")
        responseData.length = 0
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        print("Connection: data received \(data)")
        responseData.appendData(data)
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        values[faultcode] = "\(error.code)"
        values[faultstring] = error.localizedDescription
        
        finish(values)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        print("Connection: finish loading")
        
        let parser = NSXMLParser(data: responseData)
        parser.delegate = self
        parser.parse()
        parser.shouldResolveExternalEntities = true
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        names.append(elementName)
        currentElement = getElementName()
        print("Parser: start element \(currentElement)")
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        print("Parser: found characters \(string)")
        values[currentElement] = string
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        print("Parser: end element \(currentElement)")
        names.removeLast()
        currentElement = getElementName()
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        print("Parser: end document")
        finish(values)
    }
    
    func finish(values: [String:String]) {
        // process response data
    }
}