//
//  ContentView.swift
//  CustomBottomSheet
//
//  Created by Zeeshan Suleman on 04/10/2022.
//

import SwiftUI

struct ContentView: View {
  
  @State var isShowingBottomSheet = false
  
  let words: [String] = [
    "birthday",
    "pancake",
    "expansion",
    "brick",
    "bushes",
    "coal",
    "calendar",
    "home",
    "pig",
    "bath",
    "reading",
    "cellar",
    "knot",
    "year",
    "ink",
  ]
  
  let screenSize = UIScreen.main.bounds
  
  var body: some View {
    ZStack{
      Rectangle()
        .foregroundColor(.blue)
        .frame(width: screenSize.width,
               height: screenSize.height)
        .ignoresSafeArea()
      
      VStack(spacing: .zero) {
//        Spacer()
        
        Rectangle()
          .frame(
            width: UIScreen.main.bounds.width,
            height: 100,
            alignment: .bottom
          )
          .foregroundColor(.black)
      }
      
      //      BottomSheetViewFromPadding(
      //        isOpen: $isShowingBottomSheet,
      //        fromTopPadding: 100
      //      ) {
      //        ScrollView {
      //          ForEach(words, id: \.self) { word in
      //            Text(word)
      //              .font(.title)
      //              .padding([.leading, .bottom])
      //              .frame(maxWidth: .infinity, alignment: .leading)
      //          }
      //        }
      //        .frame(maxWidth: .infinity, alignment: .leading)
      //        .animation(.easeInOut, value: words)
      //      }
    }
  }
  
  
}

