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
      addNewTask: viewModel.AddNewTask
    )
  }
}

struct AllTasksDisplay: View {
  var tasks: [Task]
  var addNewTask: () -> Void
  
  var body: some View {
    VStack {
      ForEach(tasks, id: \.self) { task in
        Text("\(task.name)")
      }
      
      Button("New Task") {
        addNewTask()
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    AllTasksDisplay(
      tasks: MockClasses.tasks,
      addNewTask: {}
    )
  }
}
