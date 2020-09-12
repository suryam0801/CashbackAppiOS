//
//  ItemsViewModel.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation

import CodableFirebase

import Firebase

struct Row : Identifiable {
    var id: Int?
    var rows:[Item]?
}

class ItemsViewModel : ObservableObject {
    private var DBHelper:DatabaseReadHelper?
    @Published var itemGrid: [Row] = []
    private var itemsList : [Item] = []

    func fetchItems () {
        DBHelper = DatabaseReadHelper()
        
        DBHelper!.fetchFromDatabase(dbInstance.db.reference(withPath: DBReferenceNames.ITEM_REF_NAME)) { snapShotArray in
            self.itemsList = SnapshotHelpers.decodeArray(modelType: Item.self, array: snapShotArray)
            self.itemGrid = Helpers.makeItemsIntoGrid(itemList: self.itemsList)
            print(self.itemGrid)
        }
    }

    func cleanup () {
        DBHelper?.removeReader()
    }
}
