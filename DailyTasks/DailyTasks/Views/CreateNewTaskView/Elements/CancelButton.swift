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
            .padding(
              EdgeInsets(
                top: .spacing16,
                leading: .spacing16,
                bottom: .spacing16,
                trailing: 0
              )
            )

          Text("Go Back")
            .padding(
              EdgeInsets(
                top: .spacing16,
                leading: 0,
                bottom: .spacing16,
                trailing: .spacing16
              )
            )
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
    CancelButton {}
      .padding()
      .previewLayout(.sizeThatFits)
  }
}
