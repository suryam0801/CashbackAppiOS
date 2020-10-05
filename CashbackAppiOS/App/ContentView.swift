//
//  ContentView.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import UIKit
import SwiftUI
import ConcentricOnboarding
import FirebaseMessaging

struct ContentView: View {
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    @State var skip = UserDefaults.standard.value(forKey: "skip") as? Bool ?? false
    @State var onboardingFinished = false
    
    var body: some View {
        VStack{
            //checking if user is signed in or not
            if status {
                HomePageView()
            } else if skip {
                HomePageView()
            } else {
                if onboardingFinished && !skip {
                    PhoneVerificationview()
                } else {
                    self.onboarding
                }
            }
        }.onAppear {
            NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { (_) in
                let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                self.status = status
            }
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name("skipChange"), object: nil, queue: .main) { (_) in
                let skip = UserDefaults.standard.value(forKey: "skip") as? Bool ?? false
                self.skip = skip
            }
        }
    }
    
    var onboarding : some View {
        let pages = (0...1).map { i in
            AnyView(PageView(title: OnBoardingData.title, imageName: OnBoardingData.imageNames[i], header: OnBoardingData.headers[i], content: OnBoardingData.contentStrings[i], textColor: OnBoardingData.textColors[i]))
        }
        
        var a = ConcentricOnboardingView(pages: pages, bgColors: OnBoardingData.colors)
        
        a.insteadOfCyclingToFirstPage = {
            self.onboardingFinished.toggle()
        }
        
        a.animationDidEnd = {
            
        }
        a.didGoToLastPage = {
        }
        
        return a
    }
}
