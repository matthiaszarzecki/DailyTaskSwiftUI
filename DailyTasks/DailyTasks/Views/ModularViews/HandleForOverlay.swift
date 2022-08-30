//
//  HandleForOverlay.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 24.04.21.
//

import SwiftUI

struct HandleForOverlay: View {
  let closeOverlay: () -> Void

  var body: some View {
    Button(
      action: {
        closeOverlay()
      },
      label: {
        Rectangle()
          .frame(width: 60, height: 6, alignment: .center)
          .mask(RoundedRectangle(cornerRadius: 3, style: .continuous))
          .foregroundColor(.dailyHabitsGray)
          .padding(
            EdgeInsets(
              top: .spacing8,
              leading: .spacing12,
              bottom: .spacing12,
              trailing: .spacing12
            )
          )
      }
    )
  }
}

struct HandleForOverlay_Previews: PreviewProvider {
  static var previews: some View {
    HandleForOverlay {}
      .padding()
      .previewLayout(.sizeThatFits)
  }
}
