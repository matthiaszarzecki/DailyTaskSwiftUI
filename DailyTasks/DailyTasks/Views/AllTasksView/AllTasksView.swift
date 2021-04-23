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
      resetTasks: viewModel.resetAllTasks,
      sortTasks: viewModel.sortTasks
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
  var sortTasks: () -> Void
  
  @State private var showNewTaskPopover = false
  @State private var showSettingsPopover = false
  
  var taskList: some View {
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
  }
  
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        // Actual Task List
        taskList
          .offset(y: 130)
        
        VStack {
          AllTasksViewUpperRow(
            tasks: tasks,
            width: geometry.size.width,
            showSettingsPopover: $showSettingsPopover
          )
          
          Spacer()
          
          AllTasksViewLowerRow(
            showNewTaskPopover: $showNewTaskPopover,
            width: geometry.size.width,
            sortTasks: sortTasks
          )
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
      resetTasks: {},
      sortTasks: {}
    )
  }
}
