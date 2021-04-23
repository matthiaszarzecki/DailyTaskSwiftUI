//
//  PartOfDayRow.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 23.04.21.
//

import SwiftUI

struct PartOfDayRow: View {
  @Binding var selectedPartOfDay: Int
  
  var body: some View {
    HStack {
      let partOfDayOptions = [
        PartOfDayOption(index: 0, name: "Morning"),
        PartOfDayOption(index: 1, name: "Daytime"),
        PartOfDayOption(index: 2, name: "Evening"),
        PartOfDayOption(index: 3, name: "All Day")
      ]
      let padding: CGFloat = 6
      
      ForEach(partOfDayOptions, id: \.self) { option in
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
                .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }
          )
        }
      }
    }
    .padding()
  }
}

struct PartOfDayRow_Previews: PreviewProvider {
  static var previews: some View {
    PartOfDayRow(selectedPartOfDay: .constant(1))
      .previewLayout(.sizeThatFits)
  }
}
