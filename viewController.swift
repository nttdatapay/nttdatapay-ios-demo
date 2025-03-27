//
//  ViewController.swift
//  Created by NDPS on 23/10/23.
//
import UIKit
import aipayiOSLibrary

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting notification to get NDPS AIPAY transaction response
        NotificationCenter.default.addObserver(self, selector: #selector(handleNdpsAipayResponse(_:)), name: nil, object: nil)
        
        let aipayPayButton = UIButton(type: .system)
        aipayPayButton.frame = CGRect(x: 150, y: 150, width: 100, height: 50)
        aipayPayButton.setTitle("Pay Now", for: .normal)
        aipayPayButton.addTarget(self, action: #selector(payButtonAction(_:)), for: .touchUpInside)
        view.addSubview(aipayPayButton)
        self.view = view
    }
    
    @objc func handleNdpsAipayResponse(_ notification: Notification) {
        if let responseData = notification.userInfo?["data"] as? String {
            print(responseData)
        }
    }
    
    @objc func payButtonAction(_ sender:UIButton!) {
        let aipayAuthRequest = ["merchId" : "317157",
                                "password": "Test@123",
                                "merchTxnId" : "txnid123456",
                                "amount" : "1",
                                "product": "NSE",
                                "custAccNo":"6567657",
                                "txnCurrency":"INR",
                                "custEmail":"test@xyz.com",
                                "custMobile":"8888888888",
                                "udf1":"udf1",
                                "udf2":"udf2",
                                "udf3":"udf3",
                                "udf4":"udf4",
                                "udf5":"udf5",
                                "encryptionKey" :"A4476C2062FFA58980DC8F79EB6A799E",
                                "decryptionKey" :"75AEF0FA1B94B3C10D4F5B268F757F11",
                                "responseHashKey" :"KEYRESP123657234",
                                "payMode": "uat"]
                
        let manager = PaymentsManager()
        manager.ndpsAipayPayments(paymentRequestData: aipayAuthRequest, controller: self)
    }
    
}
