//
//  ProgressBar.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 17.04.21.
//

import SwiftUI

struct ProgressBar: View {
  let width: CGFloat
  let value: Double

  private let height: CGFloat = 10

  var body: some View {
    ZStack(alignment: .leading) {
      Rectangle()
        .frame(width: width, height: height)
        .opacity(0.3)
        .foregroundColor(.gray)

      Rectangle()
        .frame(
          width: min(CGFloat(self.value) * width, width),
          height: height
        )
        .foregroundColor(.dailyHabitsGreen)
        .mask(RoundedRectangle(cornerRadius: height / 2, style: .continuous))
        .animation(.easeOut(duration: 0.75), value: value)
    }
    .mask(RoundedRectangle(cornerRadius: height / 2, style: .continuous))
  }
}

struct ProgressBar_Previews: PreviewProvider {
  static var previews: some View {
    ProgressBar(
      width: PreviewConstants.width,
      value: 0.3
    )
    .padding()
    .previewLayout(.sizeThatFits)
  }
}
