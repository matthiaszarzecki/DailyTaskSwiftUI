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
      offsets: viewModel.state.offsets,
      addNewTask: viewModel.addNewTask,
      editTask: viewModel.editTask,
      updateTask: viewModel.toggleTaskAsDone,
      deleteAllTasks: viewModel.deleteAllTasks,
      checkIfTasksNeedResetting: viewModel.checkIfTasksNeedResetting,
      resetTasks: viewModel.resetAllTasks,
      sortTasks: viewModel.sortTasks,
      deleteSingleTask: viewModel.deleteSingleTask,
      setOffset: viewModel.setOffset
    )
  }
}

struct AllTasksDisplay: View {
  var tasks: [Task]
  var offsets: [CGFloat]
  var addNewTask: (_ task: Task) -> Void
  var editTask: (_ task: Task) -> Void
  var updateTask: (_ id: UUID) -> Void
  var deleteAllTasks: () -> Void
  var checkIfTasksNeedResetting: () -> Void
  var resetTasks: () -> Void
  var sortTasks: () -> Void
  var deleteSingleTask: (_ id: UUID) -> Void
  var setOffset: (_ index: Int, _ offset: CGFloat) -> Void
  
  @AppStorage("user_name") var userName: String = ""

  @State private var currentlyEditedTaskIndex = 0

  @State private var showNewTaskPopover = false
  @State private var showUpdateTaskPopover = false
  @State private var showSettingsPopover = false

  let upperPartHeight: CGFloat = 128
  let lowerPartHeight: CGFloat = 0
  var upperAndLowerPartHeight: CGFloat {
    return upperPartHeight + lowerPartHeight
  }
  
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        // Actual Task List
        VStack {
          // Spacer
          Rectangle()
            .foregroundColor(.clear)
            .frame(
              width: geometry.size.width,
              height: 124,
              alignment: .center
            )
          
          TaskList(
            tasks: tasks,
            offsets: offsets,
            editTask: editTask,
            toggleTaskAsDone: updateTask,
            setOffset: setOffset,
            showUpdateTaskPopover: $showUpdateTaskPopover,
            currentlyEditedTaskIndex: $currentlyEditedTaskIndex
          )
          .frame(
            width: geometry.size.width,
            height: geometry.size.height - 100,
            alignment: .top
          )
          
          // Sort Button
          .overlay(
            Button(
              action: {
                withAnimation {
                  sortTasks()
                }
              },
              label: {
                VStack {
                  Image(systemName: "arrow.up.arrow.down")
                  Text("Sort")
                    .font(.system(size: 12))
                }
                .padding()
                .frame(width: 60, height: 60, alignment: .center)
                .backgroundColor(.dailyHabitsGreen)
                .foregroundColor(.white)
                .mask(
                  RoundedRectangle(
                    cornerRadius: 20,
                    style: .continuous
                  )
                )
                .padding()
                .shadow(radius: 10)
              }
            ),
            alignment: .bottomTrailing
          )
          // New Task Button
          .overlay(
            Button(
              action: {
                withAnimation {
                  showNewTaskPopover = true
                }
              },
              label: {
                VStack {
                  Image(systemName: "plus")
                  Text("New")
                    .font(.system(size: 12))
                }
                .padding()
                .frame(width: 60, height: 60, alignment: .center)
                .backgroundColor(.dailyHabitsGreen)
                .foregroundColor(.white)
                .mask(
                  RoundedRectangle(
                    cornerRadius: 20,
                    style: .continuous
                  )
                )
                .padding()
                .shadow(radius: 10)
              }
            ),
            alignment: .bottomLeading
          )
        }
        
        VStack {
          AllTasksViewUpperRow(
            tasks: tasks,
            width: geometry.size.width,
            height: upperPartHeight,
            showSettingsPopover: $showSettingsPopover,
            userName: $userName
          )
          
          Spacer()
        }
      }
      
      if showNewTaskPopover {
        OverlayBackground(closeOverlay: closeCreateTaskView)
        CreateNewTaskView(
          width: geometry.size.width,
          addNewTask: addNewTask,
          closeOverlay: closeCreateTaskView
        )
      }
      
      if showUpdateTaskPopover {
        OverlayBackground(closeOverlay: closeEditTaskView)
        EditTaskView(
          width: geometry.size.width,
          task: tasks[currentlyEditedTaskIndex],
          editTask: editTask,
          deleteSingleTask: deleteSingleTask,
          closeOverlay: closeEditTaskView
        )
      }
      
      if showSettingsPopover {
        OverlayBackground(closeOverlay: closeSettingsView)
        SettingsView(
          width: geometry.size.width,
          deleteAllTasks: deleteAllTasks,
          resetTasks: resetTasks,
          closeOverlay: closeSettingsView,
          userName: $userName
        )
      }
    }
    
    // When the app is put to the foreground,
    // check if a reset should happen.
    .onReceive(
      NotificationCenter.default.publisher(
        for: UIApplication.willEnterForegroundNotification
      )
    ) { _ in
      print("### Checking for update after putting app into foreground")
      checkIfTasksNeedResetting()
    }
  }
  
  func closeCreateTaskView() {
    withAnimation {
      showNewTaskPopover = false
    }
  }
  
  func closeEditTaskView() {
    withAnimation {
      showUpdateTaskPopover = false
      setOffset(currentlyEditedTaskIndex, 0)
    }
  }
  
  func closeSettingsView() {
    withAnimation {
      showSettingsPopover = false
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    AllTasksDisplay(
      tasks: MockClasses.tasks,
      // Offsets MUST be the same length as tasks
      offsets: Array.init(repeating: 0, count: MockClasses.tasks.count),
      addNewTask: {_ in },
      editTask: {_ in },
      updateTask: {_ in },
      deleteAllTasks: {},
      checkIfTasksNeedResetting: {},
      resetTasks: {},
      sortTasks: {},
      deleteSingleTask: {_ in },
      setOffset: {_, _ in }
    )
  }
}
