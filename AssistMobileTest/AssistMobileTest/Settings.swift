//
//  Settings.swift
//  AssistPayTest
//
//  Created by Sergey Kulikov on 03.08.15.
//  Copyright (c) 2015 Assist. All rights reserved.
//

import Foundation

class Settings {
    
    static let defaults = UserDefaults.standard
    
    static var useOneClick: Bool {
        get {
        return defaults.bool(forKey: "OneClick")
        }
        
        set {
            defaults.set(newValue, forKey: "OneClick")
        }
    }
    
    static var customerId: String? {
        get {
        return defaults.string(forKey: "CustomerId")
        }
        
        set {
            defaults.setValue(newValue, forKey: "CustomerId")
        }
    }
    
    static var langauge: String? {
        get {
        return defaults.string(forKey: "Language")
        }
        
        set {
            defaults.setValue(newValue, forKey: "Language")
        }
    }
    
    static var useSignature: Bool {
        get {
        return defaults.bool(forKey: "Signature")
        }
        
        set {
            defaults.set(newValue, forKey: "Signature")
        }
    }
    
    static var host: String? {
        get {
        return defaults.string(forKey: "Host")
        }
        
        set {
            defaults.setValue(newValue, forKey: "Host")
        }
    }
    
    static var privateKey: Data? {
        get {
        return defaults.data(forKey: "PrivateKey")
        }
        
        set {
            defaults.setValue(newValue, forKey: "PrivateKey")
        }
    }
    
    static var lastname: String? {
        get {
        return defaults.string(forKey: "Lastname")
        }
        
        set {
            defaults.setValue(newValue, forKey: "Lastname")
        }
    }
    
    static var firstname: String? {
        get {
        return defaults.string(forKey: "Firstname")
        }
        
        set {
            defaults.setValue(newValue, forKey: "Firstname")
        }
    }
    
    static var middlename: String? {
        get {
        return defaults.string(forKey: "Middlename")
        }
        set {
            defaults.setValue(newValue, forKey: "Middlename")
        }
    }
    
    static var email: String? {
        get {
        return defaults.string(forKey: "Email")
        }
        set {
            defaults.setValue(newValue, forKey: "Email")
        }
    }
    
    static var mobilePhone: String? {
        get {
        return defaults.string(forKey: "MobilePhone")
        }
        set {
            defaults.setValue(newValue, forKey: "MobilePhone")
        }
    }
    
    static var address: String? {
        get {
        return defaults.string(forKey: "Address")
        }
        set {
            defaults.setValue(newValue, forKey: "Address")
        }
    }
    
    static var workPhone: String? {
        get {
        return defaults.string(forKey: "WorkPhone")
        }
        set {
            defaults.setValue(newValue, forKey: "WorkPhone")
        }
    }
    
    static var homePhone: String? {
        get {
        return defaults.string(forKey: "HomePhone")
        }
        set {
            defaults.setValue(newValue, forKey: "HomePhone")
        }
    }
    
    static var fax: String? {
        get {
        return defaults.string(forKey: "Fax")
        }
        set {
            defaults.setValue(newValue, forKey: "Fax")
        }
    }
    
    static var country: String? {
        get {
        return defaults.string(forKey: "Country")
        }
        set {
            defaults.setValue(newValue, forKey: "Country")
        }
    }
    
    static var state: String? {
        get {
        return defaults.string(forKey: "State")
        }
        set {
            defaults.setValue(newValue, forKey: "State")
        }
    }
    
    static var city: String? {
        get {
        return defaults.string(forKey: "City")
        }
        set {
            defaults.setValue(newValue, forKey: "City")
        }
    }
    
    static var zip: String? {
        get {
        return defaults.string(forKey: "Zip")
        }
        set {
            defaults.setValue(newValue, forKey: "Zip")
        }
    }
}
