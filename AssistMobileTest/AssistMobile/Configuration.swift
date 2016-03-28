//
//  Configuration.swift
//  AssistPayTest
//
//  Created by Sergey Kulikov on 01.07.15.
//  Copyright (c) 2015 Assist. All rights reserved.
//

import Foundation
import UIKit


public class AssistLinks {
    public static var currentHost = hosts[0]
    public static let hosts = ["https://payments.t.paysecure.ru", "https://payments.paysecure.ru", "https://test.paysecure.ru", "https://test.paysec.by", "https://payments.paysec.by" ]
    
    static let RegService = "/registration/mobileregistration.cfm"
    static let PayPagesService = "/pay/order.cfm"
    static let ResultService = "/orderresult/mobileorderresult.cfm"
}

class Configuration {
    
    private static var regIdField: String {
        return "\(appName).\(version).AssistRegId"
    }
    
    static let defaults = NSUserDefaults.standardUserDefaults()
    
    static var regId: String? {
        get {
        if let regId = defaults.stringForKey(regIdField) {
        return regId
    } else {
        return nil
        }
        }
        
        set {
            defaults.setValue(newValue, forKey: regIdField)
        }
    }
    
    static var appName: String? {
        get {
            return NSBundle.mainBundle().infoDictionary!["CFBundleName"] as? String
        }
    }
    
    static var version: String? {
        return NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as? String
    }
    
    static var uuid: String? {
        get {
            if let idForVendor = UIDevice.currentDevice().identifierForVendor {
                return "IOS" + idForVendor.UUIDString
            } else {
                return nil
            }
        }
    }
    
    static var model: String? {
        get {
            var sysInfo: [CChar] = Array(count: sizeof(utsname), repeatedValue: 0)
            
            let machine = sysInfo.withUnsafeMutableBufferPointer {
                (inout ptr: UnsafeMutableBufferPointer<CChar>) -> String in
                // Call uname and let it write into the memory Swift allocated for the array
                uname(UnsafeMutablePointer<utsname>(ptr.baseAddress))
                
                // Now here is the ugly part: `machine` is the 5th member of `utsname` and
                // each member member is `_SYS_NAMELEN` sized. We skip the the first 4 members
                // of the struct which will land us at the memory address of the `machine`
                // member
                let machinePtr = ptr.baseAddress.advancedBy(Int(_SYS_NAMELEN * 4))
                
                // Create a Swift string from the C string
                return String.fromCString(machinePtr)!
            }
            return machine
        }
    }
    
    static var preferredLang: String? {
        get {
            return NSLocale.preferredLanguages()[0]
        }
    }
    
}