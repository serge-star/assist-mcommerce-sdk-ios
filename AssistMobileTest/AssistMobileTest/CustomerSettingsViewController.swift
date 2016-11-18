//
//  CustomerSettingsViewController.swift
//  AssistPayTest
//
//  Created by Sergey Kulikov on 07.08.15.
//  Copyright (c) 2015 Assist. All rights reserved.
//

import UIKit

class CustomerSettingsViewController: UIViewController {
    
    @IBOutlet weak var lastname: UITextField! {
        didSet {
            lastname.text = Settings.lastname ?? ""
        }
    }
    
    @IBOutlet weak var firstname: UITextField! {
        didSet {
            firstname.text = Settings.firstname ?? ""
        }
    }
    
    @IBOutlet weak var middlename: UITextField! {
        didSet {
            middlename.text = Settings.middlename ?? ""
        }
    }
    
    @IBOutlet weak var email: UITextField! {
        didSet {
            email.text = Settings.email ?? ""
        }
    }
    
    @IBOutlet weak var mobilePhone: UITextField! {
        didSet {
            mobilePhone.text = Settings.mobilePhone ?? ""
        }
    }
    
    @IBAction func close(_ sender: UIButton) {
        Settings.lastname = lastname.text
        Settings.firstname = firstname.text
        Settings.middlename = middlename.text
        Settings.email = email.text
        Settings.mobilePhone = mobilePhone.text
        
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
