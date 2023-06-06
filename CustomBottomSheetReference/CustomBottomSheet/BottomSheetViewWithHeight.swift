//
//  BottomSheetViewWithHeight.swift
//  CustomBottomSheet
//
//  Created by jae on 2023/06/02.
//

import SwiftUI

private enum Constants {
  static let radius: CGFloat = 16
  static let indicatorHeight: CGFloat = 6
  static let indicatorWidth: CGFloat = 60
  static let snapRatio: CGFloat = 0.25
  static let minHeightRatio: CGFloat = 0.3
}

struct BottomSheetViewWithHeight<Content: View>: View {
  @Binding var isOpen: Bool

  let maxHeight: CGFloat
  let minHeight: CGFloat
  let content: Content

  @GestureState private var translation: CGFloat = 0

  private var offset: CGFloat {
    isOpen ? 0 : maxHeight - minHeight
  }

  private var indicator: some View {
    RoundedRectangle(cornerRadius: Constants.radius)
      .fill(Color.secondary)
      .frame(
        width: Constants.indicatorWidth,
        height: Constants.indicatorHeight
      ).onTapGesture {
        isOpen.toggle()
      }
  }

  init(isOpen: Binding<Bool>, maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
    minHeight = maxHeight * Constants.minHeightRatio
    self.maxHeight = maxHeight
    self.content = content()
    _isOpen = isOpen
  }

  var body: some View {
    GeometryReader { geometry in
      VStack(spacing: 0) {
        indicator.padding()
        content
      }
      .frame(
        width: geometry.size.width,
        height: maxHeight, alignment: .top
      )
      .background(.white)
      .cornerRadius(Constants.radius)
      .frame(height: geometry.size.height, alignment: .bottom)
      .offset(y: max(offset + translation, 0))
      .animation(.interactiveSpring())
      .gesture(
        DragGesture().updating($translation) { value, state, _ in
          state = value.translation.height
        }.onEnded { value in
          let snapDistance = maxHeight * Constants.snapRatio
          guard abs(value.translation.height) > snapDistance else {
            return
          }
          isOpen = value.translation.height < 0
        }
      )
    }
  }
}

struct BottomSheetView_Previews: PreviewProvider {
  static var previews: some View {
    BottomSheetViewWithHeight(isOpen: .constant(false), maxHeight: 600) {
      Rectangle().fill(Color.red)
    }.edgesIgnoringSafeArea(.all)
  }
}

