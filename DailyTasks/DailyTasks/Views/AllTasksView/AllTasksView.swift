//
//  ContentView.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 13.04.21.
//

import SwiftUI
import UserNotifications

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
  let tasks: [Task]
  let offsets: [CGFloat]
  let addNewTask: (_ task: Task) -> Void
  let editTask: (_ task: Task) -> Void
  let updateTask: (_ id: UUID) -> Void
  let deleteAllTasks: () -> Void
  let checkIfTasksNeedResetting: () -> Void
  let resetTasks: () -> Void
  let sortTasks: () -> Void
  let deleteSingleTask: (_ id: UUID) -> Void
  let setOffset: (_ index: Int, _ offset: CGFloat) -> Void

  @AppStorage("user_name") var userName = ""

  @State private var currentlyEditedTaskIndex: Int = .zero
  @State private var isPrivacyEnabled = false

  @State private var showNewTaskPopover = false
  @State private var showUpdateTaskPopover = false
  @State private var showSettingsPopover = false

  private let upperPartHeight: CGFloat = 128
  private let lowerPartHeight: CGFloat = .zero
  private var upperAndLowerPartHeight: CGFloat {
    upperPartHeight + lowerPartHeight
  }

  var body: some View {
    GeometryReader { geometry in
      ZStack {
        // Actual Task List
        VStack(spacing: 0) {
          // Spacer
          Rectangle()
            .foregroundColor(.clear)
            .frame(
              width: geometry.size.width,
              height: 124,
              alignment: .leading
            )

          TaskList(
            tasks: tasks,
            offsets: offsets,
            editTask: editTask,
            toggleTaskAsDone: updateTask,
            setOffset: setOffset,
            showUpdateTaskPopover: $showUpdateTaskPopover,
            currentlyEditedTaskIndex: $currentlyEditedTaskIndex,
            isPrivacyEnabled: isPrivacyEnabled
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

        VStack(spacing: 0) {
          AllTasksViewUpperRow(
            tasks: tasks,
            width: geometry.size.width,
            height: upperPartHeight,
            showSettingsPopover: $showSettingsPopover,
            userName: $userName,
            isPrivacyEnabled: isPrivacyEnabled
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
          userName: $userName,
          isPrivacyEnabled: $isPrivacyEnabled
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

      UNUserNotificationCenter.current().requestAuthorization(
        options: [.alert, .badge, .sound]
      ) { success, error in
        if success {
          print("All set!")
        } else if let error = error {
          print(error.localizedDescription)
        }
      }

      let current = UNUserNotificationCenter.current()

      current.getNotificationSettings { settings in
        if settings.authorizationStatus == .notDetermined {
          // Notification permission has not been asked yet
          print("Notifications have not been requested yet")
        } else if settings.authorizationStatus == .denied {
          // Notification permission was previously denied, go to settings & privacy to re-enable
          print("Notifications have been denied")
        } else if settings.authorizationStatus == .authorized {
          // Notification permission was already granted
          print("Notifications have been granted")

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

          // add our notification request
          UNUserNotificationCenter.current().add(request)
        }
      }
    }
  }

  private func closeCreateTaskView() {
    withAnimation {
      showNewTaskPopover = false
    }
  }

  private func closeEditTaskView() {
    withAnimation {
      showUpdateTaskPopover = false
      setOffset(currentlyEditedTaskIndex, 0)
    }
  }

  private func closeSettingsView() {
    withAnimation {
      showSettingsPopover = false
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let tasks: [Task] = .mockTasks

    AllTasksDisplay(
      tasks: tasks,
      // Offsets-array MUST be the same length as tasks
      offsets: Array(repeating: 0, count: tasks.count),
      addNewTask: { _ in },
      editTask: { _ in },
      updateTask: { _ in },
      deleteAllTasks: {},
      checkIfTasksNeedResetting: {},
      resetTasks: {},
      sortTasks: {},
      deleteSingleTask: { _ in },
      setOffset: { _, _ in }
    )
  }
}
