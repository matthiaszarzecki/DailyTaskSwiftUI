//
//  View-Extension.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 13.04.21.
//

import SwiftUI

extension View {
  /// Sets the background to a color.
  func backgroundColor(_ color: Color) -> some View {
    background(color)
  }

  /// Allows to only round specific corners.
  func cornerRadius(
    _ radius: CGFloat,
    corners: UIRectCorner
  ) -> some View {
    clipShape(
      RoundedCorner(
        radius: radius,
        corners: corners
      )
    )
  }
}
