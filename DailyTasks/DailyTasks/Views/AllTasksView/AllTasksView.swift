//
//  ContentView.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 13.04.21.
//

import SwiftUI

struct AllTasksView: View {
  @ObservedObject private var viewModel = AllTasksViewModel()
  
  var body: some View {
    AllTasksDisplay(
      tasks: viewModel.state.allTasks,
      addNewTask: viewModel.addNewTask,
      updateTask: viewModel.updateTask,
      deleteAllTasks: viewModel.deleteAllTasks,
      checkIfTasksNeedResetting: viewModel.checkIfTasksNeedResetting,
      resetTasks: viewModel.resetAllTasks
    )
  }
}

struct AllTasksDisplay: View {
  var tasks: [Task]
  var addNewTask: (_ name: String) -> Void
  var updateTask: (_ id: UUID) -> Void
  var deleteAllTasks: () -> Void
  var checkIfTasksNeedResetting: () -> Void
  var resetTasks: () -> Void
  
  @State private var showNewTaskPopover = false
  
  var deleteAllTasksButton: some View {
    Button(
      action: {
        deleteAllTasks()
      },
      label: {
        Text("Delete All Tasks")
          .padding()
          .backgroundColor(.red)
          .foregroundColor(.white)
          .cornerRadius(12)
      }
    )
  }
  
  var resetAllTasksButton: some View {
    Button(
      action: {
        resetTasks()
      },
      label: {
        Text("Reset All Tasks")
          .padding()
          .backgroundColor(.green)
          .foregroundColor(.white)
          .cornerRadius(12)
      }
    )
  }
  
  var newTaskButton: some View {
    Button(
      action: {
        //addNewTask()
        showNewTaskPopover = true
      },
      label: {
        Text("New Task")
          .padding()
          .backgroundColor(.blue)
          .foregroundColor(.white)
          .cornerRadius(12)
      }
    )
  }
  
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        VStack {
          Text("Your Daily Tasks")
            .font(.title)
            .frame(width: geometry.size.width - 16*2, height: 50, alignment: .leading)
          
          List {
            ForEach(tasks, id: \.self) { task in
              Button(
                action: {
                  updateTask(task.id)
                },
                label: {
                  TaskCell(task: task)
                }
              )
            }
          }
          
          HStack {
            deleteAllTasksButton
            resetAllTasksButton
            newTaskButton
          }
        }
      }
      
      if showNewTaskPopover {
        CreateNewTaskView(
          showCreateTaskView: $showNewTaskPopover,
          width: geometry.size.width,
          addNewTask: addNewTask
        )
      }
    }

    // When the app is put to the foreground,
    // check if a reset should happen.
    .onReceive(
      NotificationCenter.default.publisher(
        for: UIApplication.willEnterForegroundNotification)
    ) { _ in
      print("Updating!")
      checkIfTasksNeedResetting()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    AllTasksDisplay(
      tasks: MockClasses.tasks,
      addNewTask: {_ in },
      updateTask: {_ in },
      deleteAllTasks: {},
      checkIfTasksNeedResetting: {},
      resetTasks: {}
    )
  }
}
