//
//  CustomBottomSheetApp.swift
//  CustomBottomSheet
//
//  Created by jae on 2023/06/05.
//

import SwiftUI

@main
struct CustomBottomSheetApp: App {
  
  init() {
    print(Device.shared.safeAreaInsets.top)
    print(Device.shared.safeAreaInsets.bottom)
  }
  
    var body: some Scene {
        WindowGroup {
            ContentView(isShowingBottomSheet: true)
        }
    }
}
