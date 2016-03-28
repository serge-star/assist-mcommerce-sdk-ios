//
//  Settings.swift
//  AssistPayTest
//
//  Created by Sergey Kulikov on 03.08.15.
//  Copyright (c) 2015 Assist. All rights reserved.
//

import Foundation

class Settings {
    
    static let defaults = NSUserDefaults.standardUserDefaults()
    
    static var useOneClick: Bool {
        get {
        return defaults.boolForKey("OneClick")
        }
        
        set {
            defaults.setBool(newValue, forKey: "OneClick")
        }
    }
    
    static var customerId: String? {
        get {
        return defaults.stringForKey("CustomerId")
        }
        
        set {
            defaults.setValue(newValue, forKey: "CustomerId")
        }
    }
    
    static var langauge: String? {
        get {
        return defaults.stringForKey("Language")
        }
        
        set {
            defaults.setValue(newValue, forKey: "Language")
        }
    }
    
    static var useSignature: Bool {
        get {
        return defaults.boolForKey("Signature")
        }
        
        set {
            defaults.setBool(newValue, forKey: "Signature")
        }
    }
    
    static var host: String? {
        get {
        return defaults.stringForKey("Host")
        }
        
        set {
            defaults.setValue(newValue, forKey: "Host")
        }
    }
    
    static var privateKey: NSData? {
        get {
        return defaults.dataForKey("PrivateKey")
        }
        
        set {
            defaults.setValue(newValue, forKey: "PrivateKey")
        }
    }
    
    static var lastname: String? {
        get {
        return defaults.stringForKey("Lastname")
        }
        
        set {
            defaults.setValue(newValue, forKey: "Lastname")
        }
    }
    
    static var firstname: String? {
        get {
        return defaults.stringForKey("Firstname")
        }
        
        set {
            defaults.setValue(newValue, forKey: "Firstname")
        }
    }
    
    static var middlename: String? {
        get {
        return defaults.stringForKey("Middlename")
        }
        set {
            defaults.setValue(newValue, forKey: "Middlename")
        }
    }
    
    static var email: String? {
        get {
        return defaults.stringForKey("Email")
        }
        set {
            defaults.setValue(newValue, forKey: "Email")
        }
    }
    
    static var mobilePhone: String? {
        get {
        return defaults.stringForKey("MobilePhone")
        }
        set {
            defaults.setValue(newValue, forKey: "MobilePhone")
        }
    }
    
    static var address: String? {
        get {
        return defaults.stringForKey("Address")
        }
        set {
            defaults.setValue(newValue, forKey: "Address")
        }
    }
    
    static var workPhone: String? {
        get {
        return defaults.stringForKey("WorkPhone")
        }
        set {
            defaults.setValue(newValue, forKey: "WorkPhone")
        }
    }
    
    static var homePhone: String? {
        get {
        return defaults.stringForKey("HomePhone")
        }
        set {
            defaults.setValue(newValue, forKey: "HomePhone")
        }
    }
    
    static var fax: String? {
        get {
        return defaults.stringForKey("Fax")
        }
        set {
            defaults.setValue(newValue, forKey: "Fax")
        }
    }
    
    static var country: String? {
        get {
        return defaults.stringForKey("Country")
        }
        set {
            defaults.setValue(newValue, forKey: "Country")
        }
    }
    
    static var state: String? {
        get {
        return defaults.stringForKey("State")
        }
        set {
            defaults.setValue(newValue, forKey: "State")
        }
    }
    
    static var city: String? {
        get {
        return defaults.stringForKey("City")
        }
        set {
            defaults.setValue(newValue, forKey: "City")
        }
    }
    
    static var zip: String? {
        get {
        return defaults.stringForKey("Zip")
        }
        set {
            defaults.setValue(newValue, forKey: "Zip")
        }
    }
}