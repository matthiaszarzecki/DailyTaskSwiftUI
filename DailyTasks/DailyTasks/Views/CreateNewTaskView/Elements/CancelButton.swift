//
//  CancelButton.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 23.04.21.
//

import SwiftUI

struct CancelButton: View {
  var closeOverlay: () -> Void
  var color: Color = .red

  var body: some View {
    Button(
      action: {
        closeOverlay()
      },
      label: {
        HStack {
          Image(systemName: "arrow.backward")
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 0))

          Text("Go Back")
            .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 16))
            .foregroundColor(.white)
        }
        .backgroundColor(color)
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
