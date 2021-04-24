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
  @State private var selectedPartOfDay = 1
  @State private var selectedIcon = "drop"
  
  private let exampleTasks = ["Drink water", "Go for a walk", "Eat fruit or vegetable", "Go for a run", "Go outside"]
  
  var body: some View {
    ZStack {
      // Background Part
      OverlayBackground(showParentView: $showCreateTaskView)

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
            CancelButton(
              showCreateTaskView: $showCreateTaskView
            )
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
        .frame(width: width - 8, height: UIScreen.main.bounds.size.height * 0.6, alignment: .center)
        .backgroundColor(.white)
        .cornerRadius(54, corners: [.topLeft, .topRight])
        .cornerRadius(46, corners: [.bottomLeft, .bottomRight])
        .shadow(color: .black, radius: 10)
        .overlay(
          HandleForOverlay(showParentView: $showCreateTaskView),
          alignment: .top
        )
      }
      // Move everything up a bit for
      // the line between the view at
      // the bottom of the screen.
      .offset(y: -4)
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
        addNewTask: { _ in }
      )
    }
  }
}
