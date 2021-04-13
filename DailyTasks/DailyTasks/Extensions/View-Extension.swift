//
//  View-Extension.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 13.04.21.
//

import SwiftUI

extension View {
  func backgroundColor(_ color: Color) -> some View {
    return self.background(Rectangle().foregroundColor(color))
  }
}
