//
//  SignatureKeyViewController.swift
//  AssistPayTest
//
//  Created by Sergey Kulikov on 06.08.15.
//  Copyright (c) 2015 Assist. All rights reserved.
//

import UIKit

class SignatureKeyViewController: UIViewController {
    
    private var privateKeyData: NSData?
    private var publicKeyData: NSData?
    
    @IBOutlet weak var privateKey: KeyView! {
        didSet {
            updateView()
        }
    }
    
    @IBAction func copyToClipboard(sender: UIButton) {
        if let data = publicKeyData {
            UIPasteboard.generalPasteboard().string = Signature.base64Encode(data)
        }
    }
    
    @IBAction func pasteFromCliboard(sender: UIButton) {
        print("paste")
        if let string = UIPasteboard.generalPasteboard().string {
            print("string: \(string)")
            if let data = NSData(base64EncodedString: string, options: NSDataBase64DecodingOptions(rawValue: 1)) {
                Settings.privateKey = data
                updateView()
            }
        }
    }
    
    @IBAction func generateKeys(sender: UIButton) {
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
    
    @IBAction func close(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func updateView() {
        if let key = Settings.privateKey {
            privateKeyData = key
            privateKey.key = key
            
            print("key is \(key)")
        } else {
            privateKey.key = nil
            
            print("key is nil")
        }
        
    }
}
