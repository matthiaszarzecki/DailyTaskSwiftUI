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
      addNewTask: viewModel.AddNewTask,
      updateTask: viewModel.updateTask
    )
  }
}

struct AllTasksDisplay: View {
  var tasks: [Task]
  var addNewTask: () -> Void
  var updateTask: (UUID) -> Void
  
  var body: some View {
    VStack {
      List {
        ForEach(tasks, id: \.self) { task in
          Button(
            action: {
              //task.status.toggle()
              print("asddsa")
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
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    AllTasksDisplay(
      tasks: MockClasses.tasks,
      addNewTask: {},
      updateTask: {_ in }
    )
  }
}
