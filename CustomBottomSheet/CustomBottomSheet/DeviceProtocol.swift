//
//  DeviceProtocol.swift
//  CustomBottomSheet
//
//  Created by jae on 2023/06/07.
//

import Foundation
import UIKit

protocol DeviceProtocol {
  var safeAreaInsets: UIEdgeInsets { get }
}

public struct Device: DeviceProtocol {
  public static let shared = Device()
  
  public var safeAreaInsets: UIEdgeInsets {
    Device.shared.keywindow?.safeAreaInsets
    ?? .init(top: .zero, left: .zero, bottom: .zero, right: .zero)
  }
  
  public var safeArea: CGRect {
    Device.shared.keywindow?.safeAreaLayoutGuide.accessibilityFrame ?? CGRect()
  }
}

extension Device {
  private var keywindow: UIWindow? {
    UIApplication.shared.connectedScenes
      .filter({ $0.activationState == .foregroundActive })
      .map({ $0 as? UIWindowScene })
      .compactMap({ $0 })
      .first?.windows
      .filter({ $0.isKeyWindow })
      .first
  }
}

