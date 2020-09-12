//
//  DetailedItemView.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct DetailedItemView : View {
    
    @Binding var show : Bool
    @State var size = ""
    
    var body : some View{
        
        VStack(spacing : 0){
            
            HStack(spacing: 18){
                
                Button(action: {
                    
                    self.show.toggle()
                    
                }) {
                    
                    Image("Back").renderingMode(.original)
                }
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    
                    Image("search").renderingMode(.original)
                }
                
                Button(action: {
                    
                }) {
                    
                    Image("shop").renderingMode(.original)
                }

            }.navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .padding(15)
                
            
            Image("pic").resizable()
            
            VStack(alignment: .leading ,spacing: 15){
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 8){
                        
                        Text("Summer Vibes").font(.largeTitle)
                        Text("$199.99").fontWeight(.heavy)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 10){
                        
                        Circle().fill(Color.green).frame(width: 20, height: 20)
                        Circle().fill(Color.blue).frame(width: 20, height: 20)
                        Circle().fill(Color.red).frame(width: 20, height: 20)
                    }
                }

                
                Text("Fitted top made from a polyamide blend. Features wide straps and chest reinforcement.")
                
                
                
                Text("Select Size")
                
                HStack{
                    
                    ForEach(sizes,id: \.self){i in
                        
                        Button(action: {
                            
                            self.size = i
                            
                        }) {
                            
                            Text(i).padding().border(Color.black, width: self.size == i ? 1.5 : 0)
                            
                        }.foregroundColor(.black)
                    }
                }

                
                HStack{
                    
                    Button(action: {
                        
                    }) {
                        
                        Text("Add To Cart").padding().border(Color.black, width: 1.4)
                        
                    }.foregroundColor(.black)
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }) {
                        
                        Text("Buy Now").padding()
                        
                    }.foregroundColor(.white)
                    .background(Color.black)
                    .cornerRadius(10)
                    
                }.padding([.leading,.trailing], 15)
                .padding(.top, 15)
                
            }.padding()
            .background(RoundedBG().fill(Color.white))
            .padding(.top, -50)
            
        }
    }
}


struct type : Identifiable{
    
    var id : Int
    var rows : [row]
}

struct row : Identifiable {
    
    var id : Int
    var name : String
    var price : String
    var image : String
   
}

// i already made a sample data.....

var sizes = ["XS","S","M","X","XL"]

var types = ["Dress","Pants","Blazers","Jackets"]

var datas = [

    type(id: 0,rows: [row(id:0,name: "Fit And Flare", price: "$199", image: "p11"),row(id:1,name: "Empire Dress", price: "$136", image: "p12")]),

    type(id: 2,rows: [row(id:0,name: "Summer Vibes", price: "$136", image: "p21"),row(id:1,name: "Flora Fun", price: "$150", image: "p22")]),

]
