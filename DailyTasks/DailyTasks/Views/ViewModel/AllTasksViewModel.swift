//
//  AllTasksViewModel.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 13.04.21.
//

import Foundation
import SwiftUI

class AllTasksViewModel: ObservableObject {
  @Published private(set) var state = AllTasksViewState()
  @AppStorage("all_daily_tasks") private var allTasksData = Data()
  @AppStorage("reset_date") private var resetDate: String = ISO8601DateFormatter().string(from: Date.distantPast)
  
  init() {
    loadAllTasks()
    
    print("Updating as!")
    checkIfTasksNeedResetting()
  }
  
  func checkIfTasksNeedResetting() {
    loadAllTasks()
    if let expiryDateParsed = ISO8601DateFormatter().date(from: resetDate),
       Date() > expiryDateParsed {
      print("RESET")
      
      // Set new reset date
      //resetDate = getResetDate()
      resetDate = getResetDateOneMinuteInTheFuture()
      
      resetAllTasks()
    } else {
      print("NO RESET")
    }
  }
  
  func resetAllTasks() {
    var counter = 0
    for index in 0..<state.allTasks.count {
      if !state.allTasks[index].status {
        state.allTasks[index].status = false
        counter += 1
      }
    }
    saveAllData()
    print("Reset \(counter) Tasks!")
  }
  
  func getResetDate() -> String {
    // Set expiry date to next day...
    let expiryAdvance = DateComponents(day: 1)
    var nextDate = Calendar.current.date(byAdding: expiryAdvance, to: Date())!
    
    // ...at 0400 in the morning.
    nextDate = Calendar.current.date(bySettingHour: 4, minute: 0, second: 0, of: nextDate)!

    let stringDate = ISO8601DateFormatter().string(from: nextDate)
    return stringDate
  }
  
  func getResetDateOneMinuteInTheFuture() -> String {
    let expiryAdvance = DateComponents(minute: 1)
    let nextDate = Calendar.current.date(byAdding: expiryAdvance, to: Date())!
    let stringDate = ISO8601DateFormatter().string(from: nextDate)
    return stringDate
  }

  // MARK: - Create, Update, Delete actions
  
  func addNewTask() {
    let task = Task(
      name: "Drink Water \(Int.random(in: 0...100))",
      status: false
    )
    state.allTasks.append(task)
    
    saveAllData()
  }
 
  func updateTask(id: UUID) {
    if let index = state.allTasks.firstIndex(where: { $0.id == id }) {
      state.allTasks[index].status.toggle()
    }
    
    saveAllData()
  }
  
  func deleteAllTasks() {
    self.allTasksData = Data()
    state.allTasks = [Task]()
  }
  
  // MARK: - Loading & Saving

  private func loadAllTasks() {
    guard let decodedTasks = try? JSONDecoder().decode([Task].self, from: allTasksData) else {
      return
    }
    state.allTasks = decodedTasks
  }
  
  private func saveAllData() {
    guard let encodedTasks = try? JSONEncoder().encode(state.allTasks) else {
      return
    }
    self.allTasksData = encodedTasks
  }
  
  // MARK: - ViewState
  
  struct AllTasksViewState {
    var allTasks = [Task]()
  }
}
