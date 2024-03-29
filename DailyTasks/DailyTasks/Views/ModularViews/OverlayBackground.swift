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
  let closeOverlay: () -> Void

  var body: some View {
    Button(action: closeOverlay) {
      Rectangle()
        .foregroundColor(.black)
        .opacity(0.6)
        .edgesIgnoringSafeArea(.all)
    }
    .transition(.opacity)
  }
}

struct OverlayBackground_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Rectangle()
        .foregroundColor(.green)
        .edgesIgnoringSafeArea(.all)

      OverlayBackground {}
    }
  }
}
