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
      updateTask: viewModel.updateTask,
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
  var updateTask: (_ id: UUID) -> Void
  var deleteAllTasks: () -> Void
  var checkIfTasksNeedResetting: () -> Void
  var resetTasks: () -> Void
  var sortTasks: () -> Void
  var deleteSingleTask: (_ id: UUID) -> Void
  var setOffset: (_ index: Int, _ offset: CGFloat) -> Void
  
  @AppStorage("user_name") var userName: String = ""
  
  @State private var showNewTaskPopover = false
  @State private var showSettingsPopover = false
  
  @GestureState var isDragging = false
  
  var taskList: some View {
    return List {
      ForEach(tasks.indices, id: \.self) { index in
        ZStack {
          Color(.red)
          
          Color(.green)
            .padding(.trailing, 65)
          
          Button(
            action: {
              updateTask(tasks[index].id)
            },
            label: {
              TaskCell(task: tasks[index])
            }
          )
          .backgroundColor(.white)
          //.offset(x: offsets[index])
          /*.gesture(
           DragGesture()
           .onChanged(
           { value in
           onChanged(value: value, index: index)
           }
           )
           .onEnded(
           { value in
           onEnded(value: value, index: index)
           }
           )
           )*/
        }
        
      }
      Rectangle()
        .frame(width: 100, height: 100, alignment: .center)
        .foregroundColor(.clear)
      /*.onDelete(
       perform: { indexSet in
       // Get Item at index
       let index = indexSet.first!
       let item = tasks[index]
       
       // Get ID of item
       let id = item.id
       
       // Send delete command to viewModel
       deleteSingleTask(id)
       }
       )*/
    }
  }
  
  func onChanged(value: DragGesture.Value, index: Int) {
    if value.translation.width < 0 {
      setOffset(index, value.translation.width)
    }
  }
  func onEnded(value: DragGesture.Value, index: Int) {
    withAnimation {
      setOffset(index, 0)
    }
  }
  
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
            .frame(width: geometry.size.width, height: 124, alignment: .center)
          
          taskList
            .frame(width: geometry.size.width, height: geometry.size.height - 100, alignment: .top)
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
                  .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
                  .padding()
                  .shadow(radius: 10)
                }
              ),
              alignment: .bottomTrailing
            )
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
                  .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
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
        for: UIApplication.willEnterForegroundNotification)
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
      offsets: Array.init(repeating: 0, count: 4),
      addNewTask: {_ in },
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
