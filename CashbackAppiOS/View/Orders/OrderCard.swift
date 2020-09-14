//
//  OrderCard.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 14/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct OrderCard: View {
    
    var order:Order
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            HStack {
                
                VStack {
                    Image("p11").resizable().frame(width: 100, height: 135)
                    Spacer()
                }

                VStack (alignment: .leading) {
                    Group {
                        Text(order.itemName).bold().font(.headline)
                        Text("\(order.itemPrice.removeZerosFromEnd())₹").font(.subheadline).foregroundColor(Color.gray)
                        Spacer().frame(height: 3)
                        Text("Size: \(order.itemSize)").font(.subheadline)
                        Spacer().frame(height: 3)
                        Text("Qty: \(order.itemQuantity.removeZerosFromEnd())").font(.subheadline)
                        Spacer().frame(height: 3)
                        Text("Cashback: \(order.cashback.removeZerosFromEnd())₹").font(.subheadline)
                    }
                    Spacer().frame(height: 3)
                    Text("Ordered on \(Helpers.convertToDate(milisecond: order.timestamp))").font(.subheadline)
                    Spacer()
                }
                
                Spacer()
            }
            
            Text("Tracking Id:").font(.subheadline)
            HStack {
                Text("\(order.trackingId ?? "Yet to be shipped")")
                Spacer()
                if order.trackingId != nil && !order.trackingId!.isEmpty {
                    Image("doc.on.doc").renderingMode(.original).onTapGesture {Helpers.copyToClipBoard(textToCopy: self.order.trackingId!)}
                }
            }.padding(10).background(Color("Color")).cornerRadius(10)
            
            Text("Order Id").font(.subheadline)
            HStack {
                Text("\(order.id)")
                Spacer()
                Image("doc.on.doc").renderingMode(.original).onTapGesture {Helpers.copyToClipBoard(textToCopy: self.order.id)}
            }.padding(10).background(Color("Color")).cornerRadius(10)
            
            Text("Trasaction Id").font(.subheadline)
            HStack {
                Text("\(order.transactionId)")
                Spacer()
                Image("doc.on.doc").renderingMode(.original).onTapGesture {Helpers.copyToClipBoard(textToCopy: self.order.transactionId)}
            }.padding(10).background(Color("Color")).cornerRadius(10)

        }.padding(10).background(Color.white)
    }
}
