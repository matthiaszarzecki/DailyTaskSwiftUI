//
//  AllTasksViewModel.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 13.04.21.
//

import Foundation

class AllTasksViewModel: ObservableObject {
  @Published private(set) var state = AllTasksViewState()
  @AppStorage("tasks") private var allTasksData = Data()
  
  init() {
    LoadAllTasks()
  }
  
  func AddNewTask() {
    let task = Task(
      name: "Drink Water \(Int.random(in: 0...100))",
      status: false
    )
    state.allTasks.append(task)
    
    guard let encodedTasks = try? JSONEncoder().encode(state.allTasks) else {
      return
    }
    self.allTasksData = encodedTasks
  }
  
  func LoadAllTasks() {
    guard let decodedTasks = try? JSONDecoder().decode([Task].self, from: allTasksData) else {
      return
    }
    state.allTasks = decodedTasks
  }
  
  struct AllTasksViewState {
    var allTasks = [Task]()
  }
}
