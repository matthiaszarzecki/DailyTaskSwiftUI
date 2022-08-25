//
//  PartOfDayRow.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 23.04.21.
//

import SwiftUI

struct PartOfDayRow: View {
  @Binding var selectedPartOfDay: Int

  private let padding: CGFloat = 6

  var body: some View {
    HStack {
      ForEach(PartOfDayOption.options, id: \.self) { option in
        if selectedPartOfDay == option.index {
          Text("\(option.name)")
            .padding(padding)
            .backgroundColor(.white)
            .foregroundColor(.gray)
            .overlay(
              RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 2)
            )
        } else {
          Button(
            action: {
              selectedPartOfDay = option.index
            },
            label: {
              Text("\(option.name)")
                .padding(padding)
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
    .padding(EdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 6))
  }
}

struct PartOfDayRow_Previews: PreviewProvider {
  static var previews: some View {
    PartOfDayRow(
      selectedPartOfDay: .constant(1)
    )
    .previewLayout(.sizeThatFits)
  }
}
