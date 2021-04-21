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
  var addNewTask: (_ task: Task) -> Void
  var updateTask: (_ id: UUID) -> Void
  var deleteAllTasks: () -> Void
  var checkIfTasksNeedResetting: () -> Void
  var resetTasks: () -> Void
  
  @State private var showNewTaskPopover = false
  @State private var showSettingsPopover = false
  
  private var doneTasks: Int {
    let doneTasks = tasks.filter { $0.status }
    return doneTasks.count
  }
  
  private var allTasks: Int {
    return tasks.count
  }
  
  private var taskDoneRatio: Double {
    if tasks.isEmpty {
      return 0.0
    } else {
      return Double(doneTasks) / Double(allTasks)
    }
  }
  
  private var progressDisplay: some View {
    let displayNumber = taskDoneRatio * 100
    let displayString = String(format: "%.0f", displayNumber)
    return Text("Progress: \(displayString)%")
  }
  
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
        withAnimation {
          showNewTaskPopover = true
        }
      },
      label: {
        Text("New Task")
          .frame(width: 250, height: 20, alignment: .center)
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
          HStack {
            Text("Your Daily Habits")
              .font(.title)
              .padding()
            
            Spacer()
            
            Button(
              action: {
                withAnimation {
                  showSettingsPopover.toggle()
                }
              },
              label: {
                Image(systemName: "gear")
                  .font(.title)
                  .padding()
              }
            )
            
          }
          
          progressDisplay
            .frame(width: geometry.size.width - 16*2, height: 20, alignment: .leading)
          
          ProgressBar(
            width: geometry.size.width - 16*2,
            value: taskDoneRatio
          )
          
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
          
          newTaskButton
        }
      }
      
      if showNewTaskPopover {
        CreateNewTaskView(
          showCreateTaskView: $showNewTaskPopover,
          width: geometry.size.width,
          addNewTask: addNewTask
        )
        .transition(.move(edge: .bottom))
      }
      
      if showSettingsPopover {
        SettingsView(
          showSettingsView: $showSettingsPopover,
          width: geometry.size.width,
          deleteAllTasks: deleteAllTasks,
          resetTasks: resetTasks
        )
        .transition(.move(edge: .bottom))
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
