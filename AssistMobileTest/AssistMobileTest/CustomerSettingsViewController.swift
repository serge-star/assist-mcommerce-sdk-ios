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
    
    @IBAction func close(sender: UIButton) {
        Settings.lastname = lastname.text
        Settings.firstname = firstname.text
        Settings.middlename = middlename.text
        Settings.email = email.text
        Settings.mobilePhone = mobilePhone.text
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
}
