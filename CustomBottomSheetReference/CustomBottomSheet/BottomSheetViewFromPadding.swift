//
//  File.swift
//  CustomBottomSheet
//
//  Created by jae on 2023/06/02.
//

import SwiftUI

fileprivate enum Metric {
  static let radius: CGFloat = 16
  static let indicatorHeight: CGFloat = 4
  static let indicatorWidth: CGFloat = 48
  static let snapRatio: CGFloat = 0.25
  static let minHeightRatio: CGFloat = 0.3
  static let deviceHeight: CGFloat = UIScreen.main.bounds.height
}

public struct BottomSheetViewFromPadding<Content: View>: View {
  @Binding var isOpen: Bool
  
  let maxHeight: CGFloat
  let minHeight: CGFloat
  let content: Content
  
  @GestureState private var translation: CGFloat = 0
  
  private var offset: CGFloat {
    isOpen ? 0 : maxHeight - minHeight
  }
  
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
    self.maxHeight = Metric.deviceHeight - fromTopPadding
    //임의로 최대 높이 에서 0.3
    self.minHeight = maxHeight * Metric.minHeightRatio
    self.content = content()
    self._isOpen = isOpen
  }
  
  public var body: some View {
    GeometryReader { geometry in
      VStack(spacing: 0) {
        self.indicator
          .padding([.top, .bottom], 10)
        self.content
      }
      //바텀시트뷰 크기
      .frame(
        width: geometry.size.width,
        height: self.maxHeight,
        alignment: .top
      )
      .background(.white)
      .cornerRadius(Metric.radius)
      //바텀시트 사용 영역 부모뷰(GeomertyReder 상위) 높이와 일치 하도록
      .frame(height: geometry.size.height, alignment: .bottom)
      //바텀시트를 드래그 해서 펼칠때 실시간으로 뷰 높이 업데이트
      .offset(y: max(self.offset + self.translation, 0))
      .animation(.interactiveSpring())
      .gesture(
        DragGesture().updating(self.$translation) { value, state, _ in
          print(self.$translation)
          state = value.translation.height
          print(abs(state))
        }.onEnded { value in
          //최대 높이의 0.25
          let snapDistance = self.maxHeight * Metric.snapRatio
          //움직인 높이가 최대 높이의 25% 를 넘어가면 바텀 뷰를 펼친다.
          guard abs(value.translation.height) > snapDistance else {
            return
          }
          self.isOpen = value.translation.height < 0
        }
      )
    }
  }
}


//struct BottomSheetView_Previews: PreviewProvider {
//  static var previews: some View {
//    BottomSheetViewFromPadding(isOpen: .constant(false), maxHeight: 600) {
//      Rectangle().fill(Color.red)
//    }.edgesIgnoringSafeArea(.all)
//  }
//}
