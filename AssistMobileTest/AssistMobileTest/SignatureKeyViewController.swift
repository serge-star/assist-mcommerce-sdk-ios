//
//  SignatureKeyViewController.swift
//  AssistPayTest
//
//  Created by Sergey Kulikov on 06.08.15.
//  Copyright (c) 2015 Assist. All rights reserved.
//

import UIKit

class SignatureKeyViewController: UIViewController {
    
    fileprivate var privateKeyData: Data?
    fileprivate var publicKeyData: Data?
    
    @IBOutlet weak var privateKey: KeyView! {
        didSet {
            updateView()
        }
    }
    
    @IBAction func copyToClipboard(_ sender: UIButton) {
        if let data = publicKeyData {
            UIPasteboard.general.string = Signature.base64Encode(data)
        }
    }
    
    @IBAction func pasteFromCliboard(_ sender: UIButton) {
        print("paste")
        if let string = UIPasteboard.general.string {
            print("string: \(string)")
            if let data = Data(base64Encoded: string, options: NSData.Base64DecodingOptions(rawValue: 1)) {
                Settings.privateKey = data
                updateView()
            }
        }
    }
    
    @IBAction func generateKeys(_ sender: UIButton) {
        let keys = Signature.generateKeys()
        if let key = keys.privateKey {
            if let data = Signature.secKeyToNSData(key) {
                Settings.privateKey = data
                updateView()
            }
        }
        
        if let key = keys.publicKey {
            if let data = Signature.secKeyToNSData(key) {
                publicKeyData = data
            }
        }
    }
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateView() {
        if let key = Settings.privateKey {
            privateKeyData = key as Data
            privateKey.key = key
            
            print("key is \(key)")
        } else {
            privateKey.key = nil
            
            print("key is nil")
        }
        
    }
}
