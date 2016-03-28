//
//  SettingsControllerViewController.swift
//  AssistPayTest
//
//  Created by Sergey Kulikov on 03.08.15.
//  Copyright (c) 2015 Assist. All rights reserved.
//

import UIKit
import AssistMobile

class SettingsControllerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    let languagePicker = UIPickerView()
    let hostPicker = UIPickerView()
    let languages = [Language.RU.rawValue, Language.EN.rawValue, Language.BY.rawValue, Language.UK.rawValue]
    
    @IBOutlet weak var useOneClick: UISwitch! {
        didSet {
            useOneClick.on = Settings.useOneClick
        }
    }
    
    @IBOutlet weak var customerId: UITextField! {
        didSet {
            if let id = Settings.customerId {
                customerId.text = id
            }
            customerId.delegate = self
        }
    }
    
    @IBOutlet weak var language: UITextField! {
        didSet {
            language.text = Settings.langauge ?? Language.RU.rawValue
            languagePicker.dataSource = self
            languagePicker.delegate = self
            language.inputView = languagePicker
        }
    }
    
    @IBOutlet weak var useSignature: UISwitch! {
        didSet {
            useSignature.on = Settings.useSignature
        }
    }
    
    @IBOutlet weak var host: UITextField! {
        didSet {
            host.text = Settings.host ?? AssistLinks.hosts[0]
            hostPicker.dataSource = self
            hostPicker.delegate = self
            host.inputView = hostPicker
        }
    }
    
    @IBAction func closeView(sender: UIButton) {
        Settings.useOneClick = useOneClick.on
        Settings.customerId = customerId.text
        Settings.langauge = language.text
        Settings.useSignature = useSignature.on
        Settings.host = host.text
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        switch pickerView {
        case languagePicker:
            return 1
        case hostPicker:
            return 1
        default:
            return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case languagePicker:
            return languages.count
        case hostPicker:
            return AssistLinks.hosts.count
        default:
            return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case languagePicker:
            return languages[row]
        case hostPicker:
            return AssistLinks.hosts[row]
        default:
            return "?"
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case languagePicker:
            language.text = languages[row]
            language.resignFirstResponder()
        case hostPicker:
            host.text = AssistLinks.hosts[row]
            host.resignFirstResponder()
        default:
            break
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
}
