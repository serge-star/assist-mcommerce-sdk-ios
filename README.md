# Assist SDK for iOS

## Integration

1. Download the last version of AssistMobile.framework or build it
2. Add the framework to your project
3. Set option Build Settings -> Build Options -> Embedded Content Contains Swift Code to YES in project settings
4. Add AssisyMobile.framework to  General->Embedded Binaries property
5. Add key NSLocationWhenInUseUsageDescription to Info.plist -> Information Property List, set type to String and value 'Permit to send geolocation data to Assist'

### Code sample Siwift

'
import UIKit
import AssistMobile

class ViewController: UIViewController, AssistPayDelegate {
    @IBOutlet weak var result: UILabel!  
    var data = PayData()
    
   
    @IBAction func startPay(sender: UIButton) {

       data.merchantId = "123456"
        data.orderNumber = "test_payment_01"
        data.orderAmount = "100.05"
        data.orderComment = "This is a test!"
        data.orderCurrency = .RUB      
        data.lastname = "Ivanov"
        data.firstname = "Ivan"
        data.middlename = "Ivanovich"
        data.email = "i3@mail.ru"
        data.mobilePhone = "+79210000000"
        data.address = "Nevskiy prospekt, 1"
        data.country = "Russian Federation"
        data.state = "Saint-Petersburg"
        data.city = "Saint-Petersburg"
        
        let pay = AssistPay(delegate: self)
        pay.start(self, withData: data)
    }  

    func payFinished(bill: String, status: PaymentStatus, message: String?) {
        let msg = message ?? ""
        result.text = "Finished: bill = \(bill), status = \(status.rawValue), message = \(msg)"
    }
}
'
