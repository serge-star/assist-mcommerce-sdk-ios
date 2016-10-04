//
//  PayData.swift
//  AssistPayTest
//
//  Created by Sergey Kulikov on 29.06.15.
//  Copyright (c) 2015 Assist. All rights reserved.
//

import Foundation

public enum Language: String {
    case RU = "RU"
    case EN = "EN"
    case BY = "BY"
    case UK = "UK"
}

public enum Currency: String {
    case RUB = "RUB"
    case USD = "USD"
    case EUR = "EUR"
    case BYN = "BYN"
    case UAH = "UAH"
}

@objc
public class PayData: RequestData {
    
    public override init() {
        fieldValues[Fields.MobileDevice] = "6"
    }
    
    private enum Fields: String {
        case MerchantId = "Merchant_ID"
        case CustomerId = "CustomerNumber"
        case OrderNumber = "OrderNumber"
        case Language = "Language"
        case OrderAmount = "OrderAmount"
        case OrderComment = "OrderComment"
        case OrderCurrency = "OrderCurrency"
        case Lastname = "Lastname"
        case Firstname = "Firstname"
        case Middlename = "Middlename"
        case Email = "Email"
        case Address = "Address"
        case HomePhone = "HomePhone"
        case WorkPhone = "WorkPhone"
        case MobilePhone = "MobilePhone"
        case Fax = "Fax"
        case Country = "Country"
        case State = "State"
        case City = "City"
        case Zip = "Zip"
        case CardPayment = "CardPayment"
        case YMPayment = "YMPayment"
        case WMPayment = "WMPayment"
        case QIWIPayment = "QIWIPayment"
        case QIWIMtsPayment = "QIWIMtsPayment"
        case QIWIMegafonPayment = "QIWIMegafonPayment"
        case QIWIBeelinePayment = "QIWIBeelinePayment"
        case MobileDevice = "MobileDevice"
        case RecurringIndicator = "RecurringIndicator"
        case RecurringMinAmount = "RecurringMinAmount"
        case RecurringMaxAmount = "RecurringMaxAmount"
        case RecurringPeriod = "RecurringPeriod"
        case RecurringMaxDate = "RecurringMaxDate"
        case PaymentMode = "PaymentMode"
        case Signature = "Signature"
        case RegistrationId = "registration_id"
        case DeviceUniqueId = "DeviceUniqueID"
        case Latitude = "Latitude"
        case Longitude = "Longitude"
        case Device = "Device"
        case ApplicationName = "ApplicationName"
        case ApplicationVersion = "ApplicationVersion"
        case OsLanguage = "OsLanguage"
    }
    
    private var fieldValues = [Fields : String]()
    
    public var merchantId: String? {
        get { return fieldValues[Fields.MerchantId] }
        set { fieldValues[Fields.MerchantId] = newValue }
    }
    
    public var customerId: String? {
        get { return fieldValues[Fields.CustomerId] }
        set { fieldValues[Fields.CustomerId] = newValue }
    }
    
    public var orderNumber: String? {
        get { return fieldValues[Fields.OrderNumber] }
        set { fieldValues[Fields.OrderNumber] = newValue }
    }
    
    public var languageStr: String? {
        get { return fieldValues[Fields.Language] }
        set { fieldValues[Fields.Language] = newValue }
    }
    
    public var language: Language? {
        get { return Language(rawValue: languageStr ?? "") }
        set { languageStr = newValue?.rawValue }
    }
    
    public var orderAmount: String? {
        get { return fieldValues[Fields.OrderAmount] }
        set { fieldValues[Fields.OrderAmount] = newValue }
    }
    
    public var orderComment: String? {
        get { return fieldValues[Fields.OrderComment] }
        set { fieldValues[Fields.OrderComment] = newValue }
    }
    
    public var orderCurrencyStr: String? {
        get { return fieldValues[Fields.OrderCurrency] }
        set { fieldValues[Fields.OrderCurrency] = newValue }
    }
    
    public var orderCurrency: Currency? {
        get { return Currency(rawValue: orderCurrencyStr ?? "") }
        set { orderCurrencyStr = newValue?.rawValue }
    }
    
    public var lastname: String? {
        get { return fieldValues[Fields.Lastname] }
        set { fieldValues[Fields.Lastname] = newValue }
    }
    
    public var firstname: String? {
        get { return fieldValues[Fields.Firstname] }
        set { fieldValues[Fields.Firstname] = newValue }
    }
    
    public var middlename: String? {
        get { return fieldValues[Fields.Middlename] }
        set { fieldValues[Fields.Middlename] = newValue }
    }
    
    public var email: String? {
        get { return fieldValues[Fields.Email] }
        set { fieldValues[Fields.Email] = newValue }
    }
    
    public var address: String? {
        get { return fieldValues[Fields.Address] }
        set { fieldValues[Fields.Address] = newValue }
    }
    
    public var homePhone: String? {
        get { return fieldValues[Fields.HomePhone] }
        set { fieldValues[Fields.HomePhone] = newValue }
    }
    
    public var workPhone: String? {
        get { return fieldValues[Fields.WorkPhone] }
        set { fieldValues[Fields.WorkPhone] = newValue }
    }
    
    public var mobilePhone: String? {
        get { return fieldValues[Fields.MobilePhone] }
        set { fieldValues[Fields.MobilePhone] = newValue }
    }
    
    public var fax: String? {
        get { return fieldValues[Fields.Fax] }
        set { fieldValues[Fields.Fax] = newValue }
    }
    
    public var country: String? {
        get { return fieldValues[Fields.Country] }
        set { fieldValues[Fields.Country] = newValue }
    }
    
    public var state: String? {
        get { return fieldValues[Fields.State] }
        set { fieldValues[Fields.State] = newValue }
    }
    
    public var city: String? {
        get { return fieldValues[Fields.City] }
        set { fieldValues[Fields.City] = newValue }
    }
    
    public var zip: String? {
        get { return fieldValues[Fields.Zip] }
        set { fieldValues[Fields.Zip] = newValue }
    }
    
    public var signature: String? {
        get { return fieldValues[Fields.Signature] }
        set { fieldValues[Fields.Signature] = newValue }
    }
    
    var registrationId: String? {
        get { return fieldValues[Fields.RegistrationId] }
        set { fieldValues[Fields.RegistrationId] = newValue }
    }
    
    var deviceUniqueId: String? {
        get { return fieldValues[Fields.DeviceUniqueId] }
        set { fieldValues[Fields.DeviceUniqueId] = newValue }
    }
    
    var latitude: String? {
        get { return fieldValues[Fields.Latitude] }
        set { fieldValues[Fields.Latitude] = newValue }
    }
    
    var longitude: String? {
        get { return fieldValues[Fields.Longitude] }
        set { fieldValues[Fields.Longitude] = newValue }
    }
    
    var device: String? {
        get { return fieldValues[Fields.Device] }
        set { fieldValues[Fields.Device] = newValue }
    }
    
    var applicationName: String? {
        get { return fieldValues[Fields.ApplicationName] }
        set { fieldValues[Fields.ApplicationName] = newValue }
    }
    
    var applicationVersion: String? {
        get { return fieldValues[Fields.ApplicationVersion] }
        set { fieldValues[Fields.ApplicationVersion] = newValue }
    }
    
    var osLanguage: String? {
        get { return fieldValues[Fields.OsLanguage] }
        set { fieldValues[Fields.OsLanguage] = newValue }
    }
    
    public var date: NSDate?
    
    override func buildRequestString() -> String {
        var req = String()
        for (key, value) in fieldValues {
            req += "\(key.rawValue)=\(value)&"
        }
        req.removeAtIndex(req.endIndex.predecessor())
        return req
    }
    
}
