//
//  BottomSheetViewTest.swift
//  CustomBottomSheet
//
//  Created by jae on 2023/06/05.
//

import SwiftUI

fileprivate enum Metric {
  static let radius: CGFloat = 16
  static let indicatorHeight: CGFloat = 4
  static let indicatorWidth: CGFloat = 48
  static let snapRatio: CGFloat = 0.25
  static let minHeightRatio: CGFloat = 0.3
  static let deviceHeight: CGFloat = UIScreen.main.bounds.height
  static let deviceWidht: CGFloat = UIScreen.main.bounds.width
}

public struct BottomSheetViewTest<Content: View>: View {
  @Binding
  var isOpen: Bool
  
  @State
  private var maxHeight: CGFloat = 300
  
  @State
  private var dragOffset: CGFloat = 0
  
  let content: Content
  
  @GestureState private var translation: CGFloat = 0
  
  private var indicator: some View {
    RoundedRectangle(cornerRadius: Metric.radius)
      .fill(Color.secondary)
      .frame(
        width: Metric.indicatorWidth,
        height: Metric.indicatorHeight
      ).onTapGesture {
        self.isOpen.toggle()
      }
  }
  
  init(isOpen: Binding<Bool>,
       fromTopPadding: CGFloat,
       @ViewBuilder content: () -> Content) {
    self.content = content()
    self._isOpen = isOpen
    
    self.maxHeight = Metric.deviceHeight - fromTopPadding
    
    if !self.isOpen {
      self.maxHeight = maxHeight * Metric.minHeightRatio
    }
  }
  
  public var body: some View {
    
    VStack(spacing: 0) {
      self.indicator
        .padding([.top, .bottom], 10)
      self.content
    }
    //바텀시트뷰 크기
    .frame(
      width: Metric.deviceWidht,
      height: self.maxHeight,
      alignment: .top
    )
    .background(.white)
    .cornerRadius(Metric.radius)
    .frame(width: Metric.deviceWidht, height: maxHeight)
    .gesture(
      DragGesture()
        .onChanged({ value in
          self.dragOffset = value.translation.height
          self.maxHeight = maxHeight - dragOffset
        })
        .onEnded({ value in
          withAnimation {
            self.dragOffset = value.translation.height
            self.maxHeight = maxHeight - dragOffset
          }
        })
      
//      DragGesture().updating(self.$translation) { value, state, _ in
//        print(self.$translation)
//        state = value.translation.height
//        print(abs(state))
//      }.onEnded { value in
//        //최대 높이의 0.25
//        let snapDistance = self.maxHeight * Metric.snapRatio
//        //움직인 높이가 최대 높이의 25% 를 넘어가면 바텀 뷰를 펼친다.
//        guard abs(value.translation.height) > snapDistance else {
//          return
//        }
//        self.isOpen = value.translation.height < 0
//      }
    )
  }
}


//struct BottomSheetView_Previews: PreviewProvider {
//  static var previews: some View {
//    BottomSheetViewFromPadding(isOpen: .constant(false), maxHeight: 600) {
//      Rectangle().fill(Color.red)
//    }.edgesIgnoringSafeArea(.all)
//  }
//}
