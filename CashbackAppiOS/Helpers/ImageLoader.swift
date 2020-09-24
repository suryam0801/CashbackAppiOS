//
//  ImageLoader.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 24/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI
import Combine
import SDWebImageSwiftUI

struct ItemImageDisplay: View {
    private var url:String
    private var width:CGFloat
    private var height:CGFloat
    
    init (url:String, width:CGFloat, height:CGFloat){
        self.url = url
        self.width = width
        self.height = height
    }
    
    var body: some View {
        VStack{
            WebImage(url: URL(string: self.url))
                // Supports options and context, like `.delayPlaceholder` to show placeholder only when error
                .onSuccess { image, data, cacheType in
                    // Success
                    // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
            }
                .resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
                .placeholder(Image(systemName: "photo")) // Placeholder Image
                // Supports ViewBuilder as well
                .placeholder {
                    Rectangle().foregroundColor(.gray)
            }
                .indicator(.activity) // Activity Indicator
                .transition(.fade(duration: 0.5)) // Fade Transition with duration
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .frame(width: self.width, height: self.height)
        }
    }
}
