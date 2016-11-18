//
//  ResultService.swift
//  AssistPayTest
//
//  Created by Sergey Kulikov on 15.07.15.
//  Copyright (c) 2015 Assist. All rights reserved.
//

import Foundation

class ResultRequest: SoapRequest {
    struct Names {
        static let DeviceID = "device_id"
        static let RegID = "registration_id"
        static let OrderNo = "ordernumber"
        static let MerchantId = "merchant_id"
        static let Date = "date"
    }
    
    init() {
        super.init(soapAction: "http://www.paysecure.ru/ws/orderresult")
    }
    
    var deviceId: String? {
        get {
            return data[Names.DeviceID]
        }
        set {
            data[Names.DeviceID] = newValue
        }
    }
    
    var regId: String? {
        get {
            return data[Names.RegID]
        }
        set {
            data[Names.RegID] = newValue
        }
    }
    
    var orderNo: String? {
        get {
            return data[Names.OrderNo]
        }
        set {
            data[Names.OrderNo] = newValue
        }
    }
    
    var merchantId: String? {
        get {
            return data[Names.MerchantId]
        }
        set {
            data[Names.MerchantId] = newValue
        }
    }
    
    var date: String? {
        get {
            return data[Names.Date]
        }
        set {
            data[Names.Date] = newValue
        }
    }
    
    override func buildRequestHeader() -> String {
        return "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ws=\"http://www.paysecure.ru/ws/\">\n<soapenv:Header/>\n<soapenv:Body>\n<ws:orderresult>\n"
    }
    
    override func buildRequestTail() -> String {
        return "</ws:orderresult>\n</soapenv:Body>\n</soapenv:Envelope>"
    }
    
}

protocol ResultServiceDelegate {
    func result(_ bill: String, state: String, message: String?)
    func resultError(_ faultcode: String?, faultstring: String?)
}

class ResultService: SoapService {
    let billnumber = ".soapenv:Envelope.soapenv:Body.ws:orderresultResponse.orderresult.order.billnumber"
    let orderstate = ".soapenv:Envelope.soapenv:Body.ws:orderresultResponse.orderresult.order.orderstate"
    let message = ".soapenv:Envelope.soapenv:Body.ws:orderresultResponse.orderresult.order.operation.customermessage"
    
    fileprivate var requestData: ResultRequest
    fileprivate var delegate: ResultServiceDelegate
    
    init(requestData: ResultRequest, delegate: ResultServiceDelegate) {
        self.requestData = requestData
        self.delegate = delegate
    }
    
    func start() {
        run(requestData)
    }
    
    override func getUrl() -> String {
        return AssistLinks.currentHost + AssistLinks.ResultService
    }
    
    override func finish(_ values: [String : String]) {
        if let bill = values[billnumber], let state = values[orderstate] {
            delegate.result(bill, state: state, message: values[message])
        } else {
            delegate.resultError(values[faultcode], faultstring: values[faultstring])
        }
    }
}
