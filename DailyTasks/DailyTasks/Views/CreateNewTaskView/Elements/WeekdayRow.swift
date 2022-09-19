//
//  WeekdayRow.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 13.09.22.
//

import SwiftUI

struct WeekdayRow: View {
  @Binding var week: Week

  private let padding: CGFloat = .spacing4
  private let width: CGFloat = 38

  var body: some View {
    HStack(spacing: .spacing4) {
      ForEach(0..<week.allDays.count, id: \.self) { index in
        let weekDay = week.allDays[index]
        let displayName = Week.getDisplayName(index: index)

        if weekDay {
          Button(
            action: {
              week.setWeekday(index: index, status: !weekDay)
            },
            label: {
              Text(displayName)
                .padding(padding)
                .frame(width: width)
                .backgroundColor(.white)
                .foregroundColor(.gray)
                .overlay(
                  RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 2)
                )
            }
          )
        } else {
          Button(
            action: {
              week.setWeekday(index: index, status: !weekDay)
            },
            label: {
              Text(displayName)
                .padding(padding)
                .frame(width: width)
                .backgroundColor(.gray)
                .foregroundColor(.white)
                .mask(
                  RoundedRectangle(
                    cornerRadius: 10,
                    style: .continuous
                  )
                )
            }
          )
        }
      }
    }
    .padding(.spacing6)
  }
}

struct WeekdayRow_Previews: PreviewProvider {
  static var previews: some View {
    WeekdayRow(
      week: .constant(.mockWeek)
    )
    .padding()
    .previewLayout(.sizeThatFits)
  }
}
