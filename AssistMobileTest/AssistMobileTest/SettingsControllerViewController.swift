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
            useOneClick.isOn = Settings.useOneClick
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
            useSignature.isOn = Settings.useSignature
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
    
    @IBAction func closeView(_ sender: UIButton) {
        Settings.useOneClick = useOneClick.isOn
        Settings.customerId = customerId.text
        Settings.langauge = language.text
        Settings.useSignature = useSignature.isOn
        Settings.host = host.text
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickerView {
        case languagePicker:
            return 1
        case hostPicker:
            return 1
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case languagePicker:
            return languages.count
        case hostPicker:
            return AssistLinks.hosts.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case languagePicker:
            return languages[row]
        case hostPicker:
            return AssistLinks.hosts[row]
        default:
            return "?"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
