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
    
    print("### Checking for update after starting app")
    checkIfTasksNeedResetting()
  }
  
  func checkIfTasksNeedResetting() {
    loadAllTasks()
    if let expiryDateParsed = ISO8601DateFormatter().date(from: resetDate),
       Date() > expiryDateParsed {
      print("### Resetting Tasks")
      
      // Set new reset date
      resetDate = getResetDate()
      //resetDate = getResetDateOneMinuteInTheFuture()
      
      resetAllTasks()
    } else {
      print("### Not Resetting Tasks")
    }
    
    sortTasks()
    saveAllData()
  }
  
  func resetAllTasks() {
    // Counter for counting how many tasks have
    // been reset (only done tasks get reset).
    var counter = 0
    
    for index in 0..<state.allTasks.count {
      // Assigning current task to constant
      // for easier reading (not setting).
      let currentTask = state.allTasks[index]
      
      if currentTask.status {
        // If task is done...
        
        // Set task status to false
        state.allTasks[index].status = false
        
        // Set highestStreak if higher than before.
        if currentTask.currentStreak > currentTask.highestStreak {
          state.allTasks[index].highestStreak = currentTask.currentStreak
        }
        
        // Increase debug counter
        counter += 1
      } else {
        // If task is NOT done...
        
        // Reset current streak to zero.
        state.allTasks[index].currentStreak = 0
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
  
  func setOffset(index: Int, offset: CGFloat) {
    state.offsets[index] = offset
  }
  
  // MARK: - Sort action
  
  func sortTasks() {
    print("### Sorting Tasks")
    
    state.allTasks.sort { firstTask, secondTask in
      if firstTask.status && secondTask.status {
        // Tasks are done, do not order them.
        return false
      }
      
      if !firstTask.status && !secondTask.status {
        // Tasks are not done, sort by partOfDay.
        return firstTask.partOfDay < secondTask.partOfDay
      }
      
      if !firstTask.status && secondTask.status {
        // First task is todo and second is done, prefer not done.
        return true
      }
      
      return false
    }
  }

  // MARK: - Create, Update, Delete actions
  
  func addNewTask(task: Task) {
    state.allTasks.append(task)
    state.offsets.append(0)
    saveAllData()
  }
 
  /// Updates single task to increase of decrease
  /// current streak and toggle done status.
  func updateTask(id: UUID) {
    if let index = state.allTasks.firstIndex(where: { $0.id == id }) {
      let oldState = state.allTasks[index].status
      if !oldState {
        state.allTasks[index].currentStreak += 1
      } else {
        state.allTasks[index].currentStreak -= 1
      }
      
      state.allTasks[index].status.toggle()
    }
    
    saveAllData()
  }
  
  func deleteSingleTask(id: UUID) {
    if let index = state.allTasks.firstIndex(where: { $0.id == id }) {
      state.allTasks.remove(at: index)
      state.offsets.remove(at: index)
    }
    
    saveAllData()
  }
  
  func deleteAllTasks() {
    self.allTasksData = Data()
    state.allTasks = [Task]()
    state.offsets = [CGFloat]()
  }
  
  // MARK: - Loading & Saving

  private func loadAllTasks() {
    guard let decodedTasks = try? JSONDecoder().decode([Task].self, from: allTasksData) else {
      return
    }
    state.allTasks = decodedTasks
    state.offsets = Array(repeating: 0, count: state.allTasks.count)
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
    var offsets = [CGFloat]()
  }
}
