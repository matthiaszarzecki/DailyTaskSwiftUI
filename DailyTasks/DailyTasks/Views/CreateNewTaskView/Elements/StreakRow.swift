//
//  StreakRow.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 23.04.21.
//

import SwiftUI

struct StreakRow: View {
  @Binding var startStreak: String

  var body: some View {
    HStack {
      TextField("Start Streak", text: $startStreak)
        .keyboardType(.numberPad)
        .frame(width: 200, height: 48, alignment: .center)
        .backgroundColor(.gray)
        .foregroundColor(.white)
        .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.top, .spacing16)
        .padding(.bottom, .spacing16)

      Button(
        action: {
          startStreak = ""
        },
        label: {
          Image(systemName: "xmark.circle.fill")
        }
      )
    }
  }
}

struct StreakRow_Previews: PreviewProvider {
  static var previews: some View {
    StreakRow(
      startStreak: .constant("")
    )
    .padding()
    .previewLayout(.sizeThatFits)
  }
}
