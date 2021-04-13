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
      deleteAllTasks: viewModel.deleteAllTasks
    )
  }
}

struct AllTasksDisplay: View {
  var tasks: [Task]
  var addNewTask: () -> Void
  var updateTask: (_ id: UUID) -> Void
  var deleteAllTasks: () -> Void
  
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
        Spacer()
        
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
        
        Spacer()
        
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
        
        Spacer()
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    AllTasksDisplay(
      tasks: MockClasses.tasks,
      addNewTask: {},
      updateTask: {_ in },
      deleteAllTasks: {}
    )
  }
}
