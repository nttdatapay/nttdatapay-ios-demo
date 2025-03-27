# nttdatapay-ios-demo

## Introduction 
This is a demo project built for iOS to demonstrate the integration of NTT DATA Payment Gateway into an iOS application.


## Installation 
  1. Download the aipayiOSLibrary.xcframework and add it to your project using Xcode.
  2. You can embed this library by following the steps below.
     Project->targets->General->Frameworks, Libraries and Embedded Content to run project select Embed Without Signing.
  3. Project->targets->Build Phases->Embed Framework->click on Code Sign On Copy
  4. Import library into your project.
        ```
        Import aipayiOSLibrary 
        ```

  5. Initiate AIPAY payments by using the following code.
        ```swift
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
        ```          

7. Create notification to capture real time response of AIPAY transaction.
   ```swift
    //setting notification to get NDPS AIPAY transaction response
    NotificationCenter.default.addObserver(self, selector: #selector(handleNdpsAipayResponse(_:)), name: nil, object: nil)
    @objc func handleNdpsAipayResponse(_ notification: Notification) {
        if let responseData = notification.userInfo?["data"] as? String {
            print(responseData)
        }
    }
   ```      

## Note:
You need to add the lines below inside your iOS app's info.plist file to support UPI Intent payment mode.
    `
```
    <key>LSApplicationQueriesSchemes</key> 
    <array> 
     <string>upi</string> 
     <string>phonepe</string> 
     <string>paytmmp</string> 
     <string>gpay</string>
     <string>tez</string> 
    </array>
```