//
//  PaymentView.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 13/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI
import Razorpay

struct RazorPayDisplay : UIViewControllerRepresentable {
    
    @Binding var showSelf:Bool
    var cartItems:[CartItem]
    var cashback:[Double]
    
    func makeUIViewController(context: Context) -> RazorPayViewController {
        tempCashback = cashback
        tempCartItems = cartItems
        return RazorPayViewController()
    }
    
    func updateUIViewController(_ uiViewController: RazorPayViewController, context: Context) {
        if transactionId != nil {
            self.showSelf = true
        }
    }
}

class RazorPayViewController: UIViewController, RazorpayPaymentCompletionProtocol {
    
    typealias Razorpay = RazorpayCheckout
    var razorpay: RazorpayCheckout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        razorpay = RazorpayCheckout.initWithKey("rzp_test_RCx7OouwDUafRY", andDelegate: self)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showPaymentForm()
    }
    
    internal func showPaymentForm(){
        let options: [String:Any] = [
            "amount": "100", //This is in currency subunits. 100 = 100 paise= INR 1.
            "currency": "INR",//We support more that 92 international currencies.
            "description": "purchase description",
            "image": "https://url-to-image.png",
            "name": "business or product name",
            "prefill": [
                "contact": "9797979797",
                "email": "foo@bar.com"
            ],
            "theme": [
                "color": "#F37254"
            ]
        ]
        razorpay.open(options)
    }
    
    public func onPaymentError(_ code: Int32, description str: String){
        transactionId = "payment_failed"
        let alertController = UIAlertController(title: "FAILURE", message: str, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.view.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    public func onPaymentSuccess(_ payment_id: String){
        transactionId = payment_id
        Helpers.makeOrderEntries(paymentId: transactionId!)
        let alertController = UIAlertController(title: "SUCCESS", message: "Payment Id \(payment_id)", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.view.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}
