//
//  ChipsContent.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 21/10/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct ChipsContent: View {
    var title:String
    var chipsData:[String]
    @Binding var selectedChip:String
    @Binding var maxCharacters:Int
    
    var body: some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        return ZStack(alignment: .topLeading, content: {
            ForEach(self.chipsData, id: \.self) { data in //loop to render all chips
                Chips(titleKey: "\(data)",
                      isSelected: selectedChip == data ? true : false,
                      callback: chipCallBack)
                    .padding(.all, 5)
                    .alignmentGuide(.leading) { dimension in  //update leading width for available width
                        if (abs(width - dimension.width) > (UIScreen.main.bounds.width - 25)) {
                            width = 0
                            height -= dimension.height
                        }
                        
                        let result = width
                        
                        if data == chipsData.last {
                            width = 0
                        } else {
                            width -= dimension.width
                        }
                        return result
                    }
                    .alignmentGuide(.top) { dimension in //update chips height origin wrt past chip
                        let result = height
                        if data == chipsData.last {
                            height = 0
                        }
                        return result
                    }
            }
        })
    }
    
    func chipCallBack (id : String) {
        selectedChip = id
        
        if self.title == "Number Of Letters" {
            var limitString = selectedChip
            var limitStringArr = limitString.components(separatedBy: " ")
            var maxCount = Int(limitStringArr[0])
            self.maxCharacters = maxCount!
        }
    }

}
