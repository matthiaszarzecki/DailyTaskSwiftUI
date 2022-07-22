//
//  TaskStatistics.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 27.04.21.
//

import SwiftUI

struct TaskStatistics: View {
  let task: Task

  var body: some View {
    HStack {
      let daysInARow = Text("Days in a row: \(task.currentStreak)")

      let record = Text(getRecordText(highestStreak: task.highestStreak))

      let partOfDay = Text(" - \(PartOfDayOption.displayString(id: task.partOfDay))")

      let fullText: Text = daysInARow + record + partOfDay
      fullText
        .font(.footnote)

      Spacer()
    }
  }

  func getRecordText(highestStreak: Int) -> String {
    var recordText = ""
    if task.highestStreak > 0 {
      recordText = " - Record: \(highestStreak)"
    }
    return recordText
  }
}

struct TaskStatistics_Previews: PreviewProvider {
  static var previews: some View {
    TaskStatistics(task: .mockTask01)
      .padding()
      .previewLayout(.sizeThatFits)

    TaskStatistics(task: .mockTask02)
      .padding()
      .previewLayout(.sizeThatFits)

    TaskStatistics(task: .mockTask05)
      .padding()
      .previewLayout(.sizeThatFits)
  }
}
