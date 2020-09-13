//
//  CartViewModel.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation

class CartViewModel : ObservableObject {
    @Published var inCartList:[CartItem] = []
    private var DBHelper:DatabaseReadHelper?

    func fetchItems () {
        DBHelper = DatabaseReadHelper()
        DBHelper!.fetchFromDatabase(dbInstance.db.reference(withPath: DBReferenceNames.USER_REF_NAME).child(customer!.id).child("cart")) { snapShotArray in

            self.inCartList = SnapshotHelpers.decodeArray(modelType: CartItem.self, array: snapShotArray)
        }
    }

    func cleanup () {
        DBHelper?.removeReader()
    }

}
