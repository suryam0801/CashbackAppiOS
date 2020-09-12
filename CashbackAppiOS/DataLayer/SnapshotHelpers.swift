//
//  SnapshotHelpers.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation
import Firebase
import CodableFirebase

class SnapshotHelpers {
    
    static func returnIndexOfSnapshot (snapshotList:[DataSnapshot], dataSnapShot:DataSnapshot) -> Int {
        var index:Int = 0
        var position:Int = 0;
        for snapshot in snapshotList {
            if snapshot.key == dataSnapShot.key {
                position = index
            }
            index = index + 1
        }
        return position
    }

    static func snapshotListModifierHelper (_ existingList : [DataSnapshot], _ action:ChildReturnStatus, _ dataSnapshot:DataSnapshot) -> [DataSnapshot] {
        
        var snapshotList:[DataSnapshot] = existingList
        
        func actionForAdded () {
            snapshotList.append(dataSnapshot)
        }
        
        func actionForChanged () {
            let index:Int = returnIndexOfSnapshot(snapshotList: snapshotList, dataSnapShot: dataSnapshot)
            snapshotList.remove(at: index)
            snapshotList.insert(dataSnapshot, at: index)
        }
        
        func actionForRemoved () {
            let index:Int = returnIndexOfSnapshot(snapshotList: snapshotList, dataSnapShot: dataSnapshot)
            snapshotList.remove(at: index)
        }
        
        switch action {
        case .added:
            actionForAdded()
            break
        case .changed:
            actionForChanged()
            break
        case .removed:
            actionForRemoved()
            break
        }
        
        return snapshotList
    }
    
    static func decodeArray<T:Codable>(modelType: T.Type, array:[DataSnapshot]) -> [T] {
        var returnArray:[T] = []
        for snapshot in array {
            do{
                returnArray.append(try FirebaseDecoder().decode(modelType.self, from: snapshot.value as Any))
            } catch let error {
                print(error)
            }
        }
        return returnArray
    }
    
    static func decodeSingleSnapShotList<T:Codable>(modelType: T.Type, list:DataSnapshot) -> [T] {
        var returnArray:[T] = []
        for snapshot in list.children.allObjects {
            do{
                let snapshotAsValue = snapshot as! DataSnapshot
                returnArray.append(try FirebaseDecoder().decode(modelType.self, from: snapshotAsValue.value!))
            } catch let error {
                print(error)
            }
        }
        return returnArray
    }

}
