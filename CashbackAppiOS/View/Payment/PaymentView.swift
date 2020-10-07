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
    
    var cartItems:[CartItem]
    var cashback:[Double]
    
    func makeUIViewController(context: Context) -> RazorPayViewController {
        tempCashback = cashback
        tempCartItems = cartItems
        return RazorPayViewController()
    }
    
    func updateUIViewController(_ uiViewController: RazorPayViewController, context: Context) {
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
            "amount": "\(tempCartTotal! * 100)", //This is in currency subunits. 100 = 100 paise= INR 1.
            "currency": "INR",//We support more that 92 international currencies.
            "description": "Please pay the total bill ammount. Your cashback will be debited back into your account within 24 hours",
            "image": "https://firebasestorage.googleapis.com/v0/b/cashback-app-94f79.appspot.com/o/Reveno%20Logo.jpg?alt=media&token=f7ee153d-56ab-43a9-a5f9-c222475f84ab",
            "name": "Reveno",
            "prefill": [
                "contact": customer!.phnNumber,
            ],
            "theme": [
                "color": "#0061FF"
            ]
        ]
        razorpay.open(options)
    }
    
    public func onPaymentError(_ code: Int32, description str: String){
        let alertController = UIAlertController(title: "FAILURE", message: str, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.view.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    public func onPaymentSuccess(_ payment_id: String){
        print(payment_id)
        transactionId = payment_id
        Helpers.makeOrderEntries(paymentId: transactionId!)
        let alertController = UIAlertController(title: "SUCCESS", message: "Payment Id \(payment_id)", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.view.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}
