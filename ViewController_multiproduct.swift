//
//  ViewController.swift
//  Created by NDPS on 23/10/23.
//
import UIKit
import aipayiOSLibrary_multiproduct
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting notification to get NDPS AIPAY transaction response
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleNdpsAipayResponse(_:)),
            name: .ndpsAipayResponseNotification,
            object: nil
        )
        
        let aipayPayButton = UIButton(type: .system)
        aipayPayButton.frame = CGRect(x: 150, y: 150, width: 100, height: 50)
        aipayPayButton.setTitle("Pay Now", for: .normal)
        aipayPayButton.addTarget(self, action: #selector(payButtonAction(_:)), for: .touchUpInside)
        view.addSubview(aipayPayButton)
        self.view = view
    }
    
    // response handling post transaction completion
    @objc func handleNdpsAipayResponse(_ notification: Notification) {
        if let responseData = notification.userInfo?["data"] as? String {
            print(responseData)
        }
    }
    
    @objc func payButtonAction(_ sender:UIButton!) {
        let merchTxnId = String.random()
        let aipayAuthRequest:[String: Any] =
                               ["merchId" : "317157",
                                "password": "Test@123",
                                "merchTxnId" : merchTxnId,
                                "amount" : "2",
                                "product": "multi",
                                "prodDetails": [
                                       ["prodName": "NSE", "prodAmount": 1],
                                       ["prodName": "AIPAY", "prodAmount": 1]
                                ],
                                "custAccNo":"6567657",
                                "txnCurrency":"INR",
                                "custEmail":"testemailyghb@xyz.com",
                                "custMobile":"8888888888",
                                "udf1":"udf1",
                                "udf2":"udf2",
                                "udf3":"udf3",
                                "udf4":"udf4",
                                "udf5":"udf5",
                                "udf6":"udf6",
                                "udf7":"udf7",
                                "udf8":"udf8",
                                "udf9":"udf9",
                                "udf10":"udf10",
                                "encryptionKey" :"A4476C2062FFA58980DC8F79EB6A799E",
                                "decryptionKey" :"75AEF0FA1B94B3C10D4F5B268F757F11",
                                "responseHashKey" :"KEYRESP123657234",
                                "payMode": "uat"]
                
                
        let manager = PaymentsManager()
        manager.ndpsAipayPayments(paymentRequestData: aipayAuthRequest, controller: self)
    }
    
    
}

extension String {

    static func random(length: Int = 10) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""

        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
    
}

extension Notification.Name {
    static let ndpsAipayResponseNotification = Notification.Name("ndpsAipayResponseNotification")
}
