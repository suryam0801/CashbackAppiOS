//
//  Loader.swift
//  CircleAppiOS
//
//  Created by Surya Manivannan on 08/08/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct Loader: View {
    
    @State private var shouldAnimate = false
    
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 20, height: 20)
                    .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                    .animation(Animation.easeInOut(duration: 0.5).repeatForever())
                Circle()
                    .fill(Color.blue)
                    .frame(width: 20, height: 20)
                    .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                    .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.3))
                Circle()
                    .fill(Color.blue)
                    .frame(width: 20, height: 20)
                    .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                    .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.6))
            }
            Text("Please wait...").padding(.top, 10)
        }.padding(20)
            .background(Color.white)
            .cornerRadius(15)
            .onAppear {
                self.shouldAnimate = true
        }
        
    }
}


//https://medium.com/better-programming/create-an-awesome-loading-state-using-swiftui-9815ff6abb80
