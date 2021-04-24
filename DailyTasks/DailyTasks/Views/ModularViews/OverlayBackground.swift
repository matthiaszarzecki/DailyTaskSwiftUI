//
//  OverlayBackground.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 24.04.21.
//

import SwiftUI

/// A Rectangle the size of the entire screen that
/// on tap sets showParentView to false.
struct OverlayBackground: View {
  @Binding var showParentView: Bool
  
  var body: some View {
    Button(
      action: {
        withAnimation {
          showParentView = false
        }
      },
      label: {
        Rectangle()
          .foregroundColor(.clear)
          .edgesIgnoringSafeArea(.all)
      }
    )
  }
}

struct OverlayBackground_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Rectangle()
        .foregroundColor(.green)
        .edgesIgnoringSafeArea(.all)
      
      OverlayBackground(
        showParentView: .constant(false)
      )
    }
  }
}
