//
//  CustomerExtraSettingsViewController.swift
//  AssistPayTest
//
//  Created by Sergey Kulikov on 07.08.15.
//  Copyright (c) 2015 Assist. All rights reserved.
//

import UIKit

class CustomerExtraSettingsViewController: UIViewController {
    
    @IBOutlet weak var address: UITextField! {
        didSet {
            address.text = Settings.address ?? ""
        }
    }
    
    @IBOutlet weak var homePhone: UITextField! {
        didSet {
            homePhone.text = Settings.homePhone ?? ""
        }
    }
    
    @IBOutlet weak var workPhone: UITextField! {
        didSet {
            workPhone.text = Settings.workPhone ?? ""
        }
    }
    
    @IBOutlet weak var fax: UITextField! {
        didSet {
            fax.text = Settings.fax ?? ""
        }
    }
    
    @IBOutlet weak var country: UITextField! {
        didSet {
            country.text = Settings.country ?? ""
        }
    }
    
    @IBOutlet weak var state: UITextField! {
        didSet {
            state.text = Settings.state ?? ""
        }
    }
    
    @IBOutlet weak var city: UITextField! {
        didSet {
            city.text = Settings.city ?? ""
        }
    }
    
    @IBOutlet weak var zip: UITextField! {
        didSet {
            zip.text = Settings.zip ?? ""
        }
    }
    
    @IBAction func close(_ sender: UIButton) {
        Settings.address = address.text
        Settings.homePhone = homePhone.text
        Settings.workPhone = workPhone.text
        Settings.fax = fax.text
        Settings.country = country.text
        Settings.state = state.text
        Settings.city = city.text
        Settings.zip = zip.text
        
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
