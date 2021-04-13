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
  var addNewTask: () -> Void
  var updateTask: (_ id: UUID) -> Void
  var deleteAllTasks: () -> Void
  var checkIfTasksNeedResetting: () -> Void
  var resetTasks: () -> Void
  
  var body: some View {
    VStack {
      List {
        ForEach(tasks, id: \.self) { task in
          Button(
            action: {
              updateTask(task.id)
            },
            label: {
              HStack {
                Text("\(task.name)")
                
                if task.status {
                  Image(systemName: "checkmark")
                    .foregroundColor(.green)
                } else {
                  Image(systemName: "circle")
                }
              }
            }
          )
        }
      }

      HStack {
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
        
        Button(
          action: {
            addNewTask()
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
      addNewTask: {},
      updateTask: {_ in },
      deleteAllTasks: {},
      checkIfTasksNeedResetting: {},
      resetTasks: {}
    )
  }
}
