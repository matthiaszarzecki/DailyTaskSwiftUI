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
  @Binding var showCreateTaskView: Bool
  var addNewTask: (_ task: Task) -> Void
  
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
          partOfDay: selectedPartOfDay
        )
        
        addNewTask(task)
        withAnimation {
          showCreateTaskView = false
        }
      },
      label: {
        Text("OK")
          .padding()
          .backgroundColor(color)
          .foregroundColor(.white)
          .cornerRadius(12)
          .shadow(radius: 10)
      }
    )
    .disabled(disabled)
  }
}

struct ConfirmTaskButton_Previews: PreviewProvider {
  static var previews: some View {
    ConfirmTaskButton(
      taskName: "Hello",
      startStreak: "",
      selectedIcon: "",
      selectedPartOfDay: 0,
      showCreateTaskView: .constant(false),
      addNewTask: { _ in }
    )
    .padding()
    .previewLayout(.sizeThatFits)
    
    ConfirmTaskButton(
      taskName: "",
      startStreak: "",
      selectedIcon: "",
      selectedPartOfDay: 0,
      showCreateTaskView: .constant(false),
      addNewTask: { _ in }
    )
    .padding()
    .previewLayout(.sizeThatFits)
  }
}
