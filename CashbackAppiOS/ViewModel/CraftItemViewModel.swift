//
//  CraftItemViewModel.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 20/10/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation

class CraftItemViewModel : ObservableObject {
    private var DBHelper:DatabaseReadHelper?
    @Published var craftItemsList : [CraftItem] = []

    func fetchItems () {
        DBHelper = DatabaseReadHelper()

        DBHelper!.fetchFromDatabase(dbInstance.db.reference(withPath: DBReferenceNames.CRAFT_ITEM_REF_NAME)) { snapShotArray in
            self.craftItemsList = SnapshotHelpers.decodeArray(modelType: CraftItem.self, array: snapShotArray)
        }
    }

    func cleanup () {
        DBHelper?.removeReader()
    }
}
