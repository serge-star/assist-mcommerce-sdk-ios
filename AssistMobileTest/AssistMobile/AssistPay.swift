//
//  AssistPay.swift
//  AssistPayTest
//
//  Created by Sergey Kulikov on 21.07.15.
//  Copyright (c) 2015 Assist. All rights reserved.
//

import UIKit

public enum PaymentStatus: String
{
    case Unknown = "Unknown"
    case InProgress = "In Process"
    case Delayed = "Delayed"
    case Approved = "Approved"
    case PartialApproved = "PartialApproved"
    case PartialDelayed = "PartialDelayed"
    case Canceled = "Canceled"
    case PartialCanceled = "PartialCanceled"
    case Declined = "Declined"
    case Timeout = "Timeout"
    case Repeated = "Repeated"
}

@objc
public protocol AssistPayDelegate: class {
    func payFinished(_ bill: String, status: String, message: String?)
}

@objc
open class AssistPay: NSObject {
    
    fileprivate var pay: PayController
    
    public init(delegate: AssistPayDelegate) {
        let bundle = Bundle(identifier: "ru.assist.AssistMobile")
        pay = PayController(nibName: "PayView", bundle: bundle)
        pay.payDelegate = delegate
    }
    
    open func start(_ controller: UIViewController, withData: PayData) {
        pay.payData = withData
        controller.present(pay, animated: true, completion: nil)
    }
    
    open func getResult(_ withData: PayData) {
        pay.payData = withData
        pay.getResult()
    }
    
}
