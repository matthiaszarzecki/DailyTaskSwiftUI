//
//  AllTasksViewModel.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 13.04.21.
//

import Foundation
import SwiftUI
import UserNotifications

class AllTasksViewModel: ObservableObject {
  struct AllTasksViewState {
    var allTasks: [Task] = []
    var offsets: [CGFloat] = []
  }

  @Published private(set) var state = AllTasksViewState()
  @AppStorage("all_daily_tasks") private var allTasksData = Data()
  @AppStorage("reset_date") private var resetDate = ISO8601DateFormatter().string(
    from: Date.distantPast
  )

  @AppStorage("is_daily_notification_scheduled") private var isNotificationScheduled = false

  init() {
    loadAllTasks()

    print("### Checking for update after starting app")
    checkIfTasksNeedResetting()
  }

  func checkIfTasksNeedResetting() {
    loadAllTasks()

    if
      let expiryDateParsed = ISO8601DateFormatter().date(from: resetDate),
      Date() > expiryDateParsed
    {
      print("### Resetting Tasks")

      // Set new reset date
      resetDate = getResetDate()
      // resetDate = getResetDateOneMinuteInTheFuture()

      resetAllTasks()

      isNotificationScheduled = false
    } else {
      print("### Not Resetting Tasks")

      setTasksToDoneBasedOnWeekday()
    }

    sortTasks()
    saveAllData()
  }

  func resetAllTasks() {
    // Set "Done" Tasks to "Todo" and increase streak counter

    // Counter for counting how many tasks have
    // been reset (only done tasks get reset).
    var counter: Int = .zero

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
        state.allTasks[index].currentStreak = .zero
      }
    }

    setTasksToDoneBasedOnWeekday()

    saveAllData()
    print("Reset \(counter) Tasks!")
  }

  func setTasksToDoneBasedOnWeekday() {
    // Set tasks to "Done" that are not supposed to happen the current weekday.
    // Weekdays are in the range of 1 to 7 BEGINNING WITH SUNDAY.
    let weekday = Calendar.current.component(.weekday, from: Date())

    for index in 0..<state.allTasks.count {
      let currentTask = state.allTasks[index]

      // If the task is still "todo"
      if !currentTask.status {
        // And the task is not supposed to be done that weekday
        if weekday == 2, !currentTask.week.monday {
          // Set that task to be done
          state.allTasks[index].status = true
        } else if weekday == 3, !currentTask.week.tuesday {
          state.allTasks[index].status = true
        } else if weekday == 4, !currentTask.week.wednesday {
          state.allTasks[index].status = true
        } else if weekday == 5, !currentTask.week.thursday {
          state.allTasks[index].status = true
        } else if weekday == 6, !currentTask.week.friday {
          state.allTasks[index].status = true
        } else if weekday == 7, !currentTask.week.saturday {
          state.allTasks[index].status = true
        } else if weekday == 1, !currentTask.week.sunday {
          state.allTasks[index].status = true
        }
      }
    }

    saveAllData()
  }

  func getResetDate() -> String {
    // Set expiry date to next day...
    let expiryAdvance = DateComponents(day: 1)
    if let nextDate = Calendar.current.date(byAdding: expiryAdvance, to: Date()) {
      // ...at 0400 in the morning.
      if let nextDateAdapted = Calendar.current.date(
        bySettingHour: 4,
        minute: 0,
        second: 0,
        of: nextDate
      ) {
        return ISO8601DateFormatter().string(from: nextDateAdapted)
      }
    }
    return ""
  }

  func getResetDateOneMinuteInTheFuture() -> String {
    let expiryAdvance = DateComponents(minute: 1)
    if let nextDate = Calendar.current.date(byAdding: expiryAdvance, to: Date()) {
      return ISO8601DateFormatter().string(from: nextDate)
    }
    return ""
  }

  func setOffset(index: Int, offset: CGFloat) {
    state.offsets[index] = offset
  }

  // MARK: - Notifications

  func setDailyReminderNotification() {
    let currentNotificationCenter = UNUserNotificationCenter.current()

    currentNotificationCenter.requestAuthorization(
      options: [.alert, .badge, .sound]
    ) { success, error in
      if success {
        print("Permissions Given!")
      } else if let error = error {
        print(error.localizedDescription)
      }
    }

    currentNotificationCenter.getNotificationSettings { settings in
      if settings.authorizationStatus == .notDetermined {
        // Notification permission has not been asked yet
        print("Notifications have not been requested yet")
      } else if settings.authorizationStatus == .denied {
        // Notification permission was previously denied, go to settings & privacy to re-enable
        print("Notifications have been denied")
      } else if settings.authorizationStatus == .authorized {
        // Notification permission was already granted
        print("Notifications have been granted")

        if !self.isNotificationScheduled {
          let notificationRequest = self.createNotification()
          currentNotificationCenter.add(notificationRequest)
          self.isNotificationScheduled = true
        }
      }
    }
  }

  private func createNotification() -> UNNotificationRequest {
    // Create notification
    let content = UNMutableNotificationContent()
    content.title = "The Day is almost over!"
    content.subtitle = "Do you have tasks still to do?"
    content.sound = UNNotificationSound.default

    var components = DateComponents()
    components.hour = 22
    components.day = Calendar.current.component(.day, from: Date())
    components.month = Calendar.current.component(.month, from: Date())
    components.year = Calendar.current.component(.year, from: Date())

    let trigger = UNCalendarNotificationTrigger(
      dateMatching: components,
      repeats: false
    )

    // choose a random identifier
    let request = UNNotificationRequest(
      identifier: UUID().uuidString,
      content: content,
      trigger: trigger
    )

    return request
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
    state.allTasks.insert(task, at: 0)
    sortTasks()
    state.offsets.append(0)
    saveAllData()
  }

  /// Updates single task to increase of decrease
  /// current streak and toggle done status.
  func toggleTaskAsDone(id: UUID) {
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

  func editTask(task: Task) {
    if let index = state.allTasks.firstIndex(where: { $0.id == task.id }) {
      state.allTasks[index] = task
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
    state.allTasks = []
    state.offsets = []
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
}
