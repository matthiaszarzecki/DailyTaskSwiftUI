//
//  CreateNewTaskView.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 15.04.21.
//

import SwiftUI

struct CreateNewTaskView: View {
  @Binding var showCreateTaskView: Bool
  var width: CGFloat
  var addNewTask: (_ task: Task) -> Void
  
  @State private var taskName = "New Task!"
  @State private var startStreak = "0"
  
  private let exampleTasks = ["Drink water", "Go for a walk", "Eat fruit or vegetable", "Go for a run", "Go outside"]
  
  @State private var selectedPartOfDay = 1
  @State private var selectedIcon = "drop"
  
  var cancelButton: some View {
    Button(
      action: {
        withAnimation {
          showCreateTaskView = false
        }
      },
      label: {
        Text("Cancel")
          .padding()
          .backgroundColor(.red)
          .foregroundColor(.white)
          .cornerRadius(12)
          .shadow(radius: 10)
      }
    )
  }

  var body: some View {
    ZStack {
      // Background Part
      Rectangle()
        .foregroundColor(.clear)
        .edgesIgnoringSafeArea(.all)
      
      VStack {
        // Upper "empty" part
        Spacer()
        
        // Actual popover part
        VStack {
          Text("Create a new task!")
            .font(.largeTitle)
            .padding()
          TaskNameTextField(taskName: $taskName, width: width)
          IconGrid(selectedIcon: $selectedIcon, width: width)
          PartOfDayRow(selectedPartOfDay: $selectedPartOfDay)
          HStack {
            cancelButton
            ConfirmTaskButton(
              taskName: taskName,
              startStreak: startStreak,
              selectedIcon: selectedIcon,
              selectedPartOfDay: selectedPartOfDay,
              showCreateTaskView: $showCreateTaskView,
              addNewTask: addNewTask
            )
          }
          .padding()
        }
        .frame(width: width - 6, height: UIScreen.main.bounds.size.height * 0.7, alignment: .center)
        .backgroundColor(.white)
        .cornerRadius(54, corners: [.topLeft, .topRight])
        .cornerRadius(46, corners: [.bottomLeft, .bottomRight])
        .shadow(radius: 6)
      }
      .edgesIgnoringSafeArea(.all)
    }
    .transition(.move(edge: .bottom))
    .onAppear {
      taskName = exampleTasks.randomElement() ?? ""
    }
  }
}

struct CreateNewTaskView_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Rectangle()
        .foregroundColor(.green)
        .edgesIgnoringSafeArea(.all)
      
      CreateNewTaskView(
        showCreateTaskView: .constant(false),
        width: PreviewConstants.width,
        addNewTask: {_ in }
      )
    }
  }
}
