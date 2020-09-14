//
//  OrdersViewModel.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 14/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation

class OrdersViewModel : ObservableObject {
    @Published var ordersList:[Order] = []
    private var DBHelper:DatabaseReadHelper?

    func fetchOrders () {
        DBHelper = DatabaseReadHelper()
        DBHelper!.fetchFromDatabase(dbInstance.db.reference(withPath: DBReferenceNames.ORDERS_REF_NAME).queryOrdered(byChild: "customerId").queryEqual(toValue: customer!.id)) { snapShotArray in
            self.ordersList = SnapshotHelpers.decodeArray(modelType: Order.self, array: snapShotArray)
        }
    }

    func cleanup () {
        DBHelper?.removeReader()
    }

}
