//
//  ViewController.swift
//  AssistPayTest
//
//  Created by Sergey Kulikov on 29.06.15.
//  Copyright (c) 2015 Assist. All rights reserved.
//

import UIKit
import AssistMobile

class ViewController: UIViewController, AssistPayDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var merchantId: UITextField! {
        didSet {
            merchantId.delegate = self
        }
    }
    @IBOutlet weak var orderNumber: UITextField! {
        didSet {
            orderNumber.delegate = self
        }
    }
    @IBOutlet weak var orderAmount: UITextField! {
        didSet {
            orderAmount.delegate = self
        }
    }
    @IBOutlet weak var orderComment: UITextField! {
        didSet {
            orderComment.delegate = self
        }
    }
    @IBOutlet weak var orderCurrency: UITextField! {
        didSet {
            currencyPicker.dataSource = self
            currencyPicker.delegate = self
            orderCurrency.inputView = currencyPicker
        }
    }
    @IBOutlet weak var result: UILabel!
    
    let currencyPicker = UIPickerView()
    
    var data = PayData()
    var currencyes = [Currency.RUB.rawValue, Currency.USD.rawValue, Currency.EUR.rawValue, Currency.BYR.rawValue, Currency.UAH.rawValue]
    
    @IBAction func startPay(sender: UIButton) {
        
        data.merchantId = merchantId.text
        data.orderNumber = orderNumber.text
        data.orderAmount = orderAmount.text
        data.orderComment = orderComment.text
        data.orderCurrency = Currency(rawValue: orderCurrency.text ?? "")
        
        if Settings.useOneClick {
            data.customerId = Settings.customerId
        }
        
        if let language = Settings.langauge {
            data.language = Language(rawValue: language)
        }
        
        if Settings.useSignature {
            data.signature = calculateSignature()
        }
        
        data.lastname = Settings.lastname
        data.firstname = Settings.firstname
        data.middlename = Settings.middlename
        data.email = Settings.email
        data.mobilePhone = Settings.mobilePhone
        
        data.address = Settings.address
        data.homePhone = Settings.homePhone
        data.workPhone = Settings.workPhone
        data.fax = Settings.fax
        data.country = Settings.country
        data.state = Settings.state
        data.city = Settings.city
        data.zip = Settings.zip
        
        let pay = AssistPay(delegate: self)
        pay.start(self, withData: data)
    }
    
    @IBAction func getResult(sender: UIButton) {
        data.merchantId = merchantId.text
        data.orderNumber = orderNumber.text
        data.orderAmount = orderAmount.text
        data.orderComment = orderComment.text
        data.orderCurrency = Currency(rawValue: orderCurrency.text ?? "")
        
        if Settings.useOneClick {
            data.customerId = Settings.customerId
        }
        
        if let language = Settings.langauge {
            data.language = Language(rawValue: language)
        }
        
        if Settings.useSignature {
            data.signature = calculateSignature()
        }
        
        data.lastname = Settings.lastname
        data.firstname = Settings.firstname
        data.middlename = Settings.middlename
        data.email = Settings.email
        data.mobilePhone = Settings.mobilePhone
        
        data.address = Settings.address
        data.homePhone = Settings.homePhone
        data.workPhone = Settings.workPhone
        data.fax = Settings.fax
        data.country = Settings.country
        data.state = Settings.state
        data.city = Settings.city
        data.zip = Settings.zip
        
        let pay = AssistPay(delegate: self)
        pay.getResult(data)
    }
    
    override func viewDidLoad() {
        merchantId.text = "679471"
        
        
        super.viewDidLoad()
    }
    
    func payFinished(bill: String, status: String, message: String?) {
        let msg = message ?? ""
        result.text = "Finished: bill = \(bill), status = \(status), message = \(msg)"
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyes.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyes[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        orderCurrency.text = currencyes[row]
        orderCurrency.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    func calculateSignature() -> String? {
        if let merchantId = data.merchantId, orderNumber = data.orderNumber, orderAmount = data.orderAmount, orderCurrency = data.orderCurrency {
            let signStr = "\(merchantId);\(orderNumber);\(orderAmount);\(orderCurrency.rawValue)"
            
            print("string to sign is \(signStr)")
            if let keyData = Settings.privateKey {
                print("keyData is \(keyData)")
                if let key = Signature.nsDataToPrivateSecKey(keyData) {
                    print("key is \(key)")
                    return Signature.calc(signStr, key: key)
                }
            }
        }
        return nil
    }
    
}

