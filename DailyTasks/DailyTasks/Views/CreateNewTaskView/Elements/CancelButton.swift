//
//  CancelButton.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 23.04.21.
//

import SwiftUI

struct CancelButton: View {
  var closeOverlay: () -> Void
  
  var body: some View {
    Button(
      action: {
        closeOverlay()
      },
      label: {
        Text("Cancel")
          .padding()
          .backgroundColor(.red)
          .foregroundColor(.white)
          .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
          .shadow(radius: 10)
      }
    )
  }
}

struct CancelButton_Previews: PreviewProvider {
  static var previews: some View {
    CancelButton(closeOverlay: {})
      .padding()
      .previewLayout(.sizeThatFits)
  }
}
