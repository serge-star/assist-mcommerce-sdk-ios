//
//  Sinature.swift
//  AssistPayTest
//
//  Created by Sergey Kulikov on 04.08.15.
//  Copyright (c) 2015 Assist. All rights reserved.
//

import Foundation
import Security

class Signature {
    
    static func digest(data: String) -> NSData
    {
        let str = data.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CUnsignedInt(data.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        CC_MD5(str!, strLen, result)
        let digestData = NSData(bytes: result, length: digestLen)
        result.destroy()
        return digestData
    }
    
    static func sign(key: SecKey, data: NSData) -> NSData?
    {
        let size = SecKeyGetBlockSize(key)
        let sig = NSMutableData(length: size)!
        let sigbytes = UnsafeMutablePointer<UInt8>(sig.mutableBytes)
        var sigLen = sig.length
        let status = SecKeyRawSign(key, SecPadding.PKCS1, UnsafePointer<UInt8>(data.bytes), data.length, sigbytes, &sigLen
        )
        if status == errSecSuccess {
            sig.length = sigLen
            return sig
        }
        print("SecKeyRawSign error: \(status)")
        return nil
    }
    
    static func base64Encode(data: NSData) -> String
    {
        return data.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
    }
    
    static func calc(data: String, key: SecKey) -> String?
    {
        print("data is \(data), key is \(key)")
        let digestData = digest(data)
        print("digestData is \(digestData)")
        if let signData = sign(key, data: digestData) {
            print("signData is \(signData)")
            return base64Encode(signData)
        } else {
            print("sign returns nil")
            return nil
        }
    }
    
    static func generateKeys() -> (publicKey: SecKey?, privateKey: SecKey?)
    {
        var publicKeyPtr = SecKey?()
        var privateKeyPtr = SecKey?()
        
        // private key parameters
        let privateKeyParams = [
            kSecAttrIsPermanent as String: true,
            kSecAttrApplicationTag as String: "ru.assist.mobile.keypair"
        ]
        
        // private key parameters
        let publicKeyParams: [String: AnyObject] = [
            kSecAttrIsPermanent as String: true,
            kSecAttrApplicationTag as String: "ru.assist.mobile.keypair"
        ]
        
        let parameters = [
            kSecAttrType as String: kSecAttrKeyTypeRSA,
            kSecAttrKeySizeInBits as String: 1024,
            kSecPublicKeyAttrs as String: publicKeyParams,
            kSecPrivateKeyAttrs as String: privateKeyParams,
        ]
        
        let status = SecKeyGeneratePair(parameters, &publicKeyPtr, &privateKeyPtr)
        if status == errSecSuccess {
            return (publicKeyPtr, privateKeyPtr)
        }
        
        return (nil, nil)
    }
    
    static func secKeyToNSData(key: SecKey) -> NSData?
    {
        let tempTag = "ru.assist.mobile.sdk.temp"
        let parameters = [
            String(kSecClass): kSecClassKey,
            String(kSecAttrApplicationTag): tempTag,
            String(kSecAttrKeyType): kSecAttrKeyTypeRSA,
            String(kSecValueRef): key,
            String(kSecReturnData): kCFBooleanTrue
        ]
        var keyPtr = AnyObject?()
        let result = SecItemAdd(parameters, &keyPtr)
        
        switch result {
        case noErr:
            let data = keyPtr as! NSData
            
            SecItemDelete(parameters)
            return data
        case errSecDuplicateItem:
            print("Duplicate item!")
            SecItemDelete(parameters)
        case errSecItemNotFound:
            print("Not found!")
        default:
            print("Error: \(result)")
        }
        return nil
    }
    
    static func nsDataToPrivateSecKey(data: NSData) -> SecKey?
    {
        let tempTag = "ru.assist.mobile.sdk.temp"
        var parameters = [
            String(kSecClass): kSecClassKey,
            String(kSecAttrApplicationTag): tempTag,
            String(kSecValueData): data,
            String(kSecAttrKeyClass): kSecAttrKeyClassPrivate,
            String(kSecAttrKeyType): kSecAttrKeyTypeRSA,
            String(kSecReturnPersistentRef): kCFBooleanTrue
        ]
        var keyRefPtr = AnyObject?()
        let result = SecItemAdd(parameters, &keyRefPtr)
        
        switch result {
        case noErr:
            parameters.removeValueForKey(String(kSecValueData))
            parameters.removeValueForKey(String(kSecReturnPersistentRef))
            parameters[String(kSecReturnRef)] = kCFBooleanTrue
            
            var keyPtr = AnyObject?()
            
            let copyResult = SecItemCopyMatching(parameters, &keyPtr)
            
            SecItemDelete(parameters)
            if copyResult != noErr {
                print("SecItemCopyMatching error: \(copyResult)")
                return nil
            }
            if let key = keyPtr {
                return (key as! SecKey)
            } else {
                print("empty or bad key")
            }
            
        case errSecDuplicateItem:
            print("Duplicate item!")
            SecItemDelete(parameters)
        case errSecItemNotFound:
            print("Not found!")
        default:
            print("Error: \(result)")
        }
        return nil
    }
}
