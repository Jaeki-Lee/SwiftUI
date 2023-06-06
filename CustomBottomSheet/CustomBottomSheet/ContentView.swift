//
//  ContentView.swift
//  CustomBottomSheet
//
//  Created by jae on 2023/06/05.
//

import SwiftUI

struct ContentView: View {
  let screenSize = UIScreen.main.bounds.size
  
  @State
  var isShowingBottomSheet = true
  
  @GestureState
  private var translation: CGFloat = 0
  
  var safeAreaHeight: CGFloat {
    UIScreen.main.bounds.size.height
  }
  
  let maxYOffSet: CGFloat = 90
  let minYOffSet: CGFloat
  let bottomSheetHeight: CGFloat
  
  var offset: CGFloat {
    isShowingBottomSheet ? maxYOffSet : minYOffSet
  }
  
  init(isShowingBottomSheet: Bool, maxYOffSet: CGFloat = 90) {
    self.isShowingBottomSheet = isShowingBottomSheet
    self.bottomSheetHeight = UIScreen.main.bounds.size.height - maxYOffSet
    self.minYOffSet = bottomSheetHeight - 90
    
    print(safeAreaHeight)
    print(maxYOffSet)
    print(minYOffSet)
  }
  
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
  
  var body: some View {
    ZStack {
      Rectangle()
        .foregroundColor(.blue)
        .ignoresSafeArea()
      
      VStack(spacing: .zero) {
        ScrollView {
          Button("Offset height") {
            print(offset)
          }
          
          ForEach(words, id: \.self) { word in
            Text(word)
              .font(.title)
              .padding([.leading, .bottom])
              .frame(maxWidth: .infinity, alignment: .leading)
          }
          
          Button("Offset height") {
            print(offset)
          }
        }
        .background(.white)
        .padding(.top, max(self.offset + translation, 0))
//        .offset(y: max(self.offset + translation, 0))
        .animation(.interactiveSpring())
        .gesture(
          DragGesture().updating(self.$translation, body: { value, state, _ in
            state = value.translation.height
          })
          .onEnded({ value in
            let snapDistance = self.bottomSheetHeight * 0.5
            
            if value.translation.height >= snapDistance {
              self.isShowingBottomSheet = false
            } else {
              self.isShowingBottomSheet = true
            }
            
            print("minYOffSet: \(self.minYOffSet)")
            print("bottomSheetHeight: \(self.bottomSheetHeight)")
          })
        )
        
        //탭 바
        Rectangle()
          .frame(
            width: screenSize.width,
            height: 120,
            alignment: .bottom
          )
          .foregroundColor(.yellow)
      }
      .edgesIgnoringSafeArea(.bottom)
      
    }
  }
  
  //  func setBottomSheetAsMax() {
  //    self.offset = maxYOffSet
  //  }
  
  
  
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(isShowingBottomSheet: true)
  }
}
