//
//  ConfirmTaskButton.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 23.04.21.
//

import SwiftUI

struct ConfirmTaskButton: View {
  var taskName: String
  var startStreak: String
  var selectedIcon: String
  var selectedPartOfDay: Int
  var isPrivate: Bool
  var addNewTask: (_ task: Task) -> Void
  var closeOverlay: () -> Void

  var body: some View {
    let disabled = taskName.isEmpty
    let color: Color = disabled ? .gray : .dailyHabitsGreen

    return Button(
      action: {
        let streak = Int(startStreak) ?? 0

        let task = Task(
          name: taskName,
          status: false,
          iconName: selectedIcon,
          currentStreak: streak,
          highestStreak: 0,
          partOfDay: selectedPartOfDay,
          isPrivate: isPrivate
        )

        addNewTask(task)
        closeOverlay()
      },
      label: {
        Text("OK")
          .padding()
          .backgroundColor(color)
          .foregroundColor(.white)
          .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
          .shadow(radius: 10)
      }
    )
    .disabled(disabled)
  }
}

struct ConfirmTaskButton_Previews: PreviewProvider {
  static var previews: some View {
    let taskNames: [String] = ["Hello", ""]

    ForEach(taskNames, id: \.self) { name in
      ConfirmTaskButton(
        taskName: name,
        startStreak: "",
        selectedIcon: "",
        selectedPartOfDay: 0,
        isPrivate: false,
        addNewTask: { _ in },
        closeOverlay: {}
      )
      .padding()
      .previewLayout(.sizeThatFits)
    }
  }
}
