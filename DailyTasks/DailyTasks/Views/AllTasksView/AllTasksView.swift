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
      sortTasks: viewModel.sortTasks,
      deleteSingleTask: viewModel.deleteSingleTask
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
  var deleteSingleTask: (_ id: UUID) -> Void
  
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
      .onDelete(
        perform: { indexSet in
          // Get Item at index
          let index = indexSet.first!
          let item = tasks[index]
          
          // Get ID of item
          let id = item.id
          
          // Send delete command to viewModel
          deleteSingleTask(id)
        }
      )
    }
  }
  
  let upperPartHeight: CGFloat = 128
  let lowerPartHeight: CGFloat = 72
  var upperAndLowerPartHeight: CGFloat {
    return upperPartHeight + lowerPartHeight
  }
  
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        // Actual Task List
        VStack {
          Rectangle()
            .foregroundColor(.clear)
            .frame(width: geometry.size.width, height: 52, alignment: .center)
          
          taskList
            .frame(width: geometry.size.width, height: geometry.size.height - upperAndLowerPartHeight, alignment: .top)
        }
 
        VStack {
          AllTasksViewUpperRow(
            tasks: tasks,
            width: geometry.size.width,
            height: upperPartHeight,
            showSettingsPopover: $showSettingsPopover
          )
          
          Spacer()
          
          AllTasksViewLowerRow(
            showNewTaskPopover: $showNewTaskPopover,
            width: geometry.size.width,
            height: lowerPartHeight,
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
      print("### Checking for update after putting app into foreground")
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
      sortTasks: {},
      deleteSingleTask: {_ in }
    )
  }
}
