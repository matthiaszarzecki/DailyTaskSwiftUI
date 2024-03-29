//
//  CreateNewTaskView.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 15.04.21.
//

import SwiftUI

struct CreateNewTaskView: View {
  let width: CGFloat
  let addNewTask: (_ task: Task) -> Void
  let closeOverlay: () -> Void

  @State private var taskName = "New Task!"
  @State private var startStreak = "0"
  @State private var selectedPartOfDay = 1
  @State private var selectedIcon = TaskIcon.drop.rawValue
  @State private var isPrivate = false
  @State private var week: Week = .fullWeek

  private let exampleTasks = [
    "Drink water",
    "Go for a walk",
    "Eat a fruit",
    "Go for a run",
    "Go outside",
    "Read 10 pages in a book",
    "Play Guitar",
    "Eat a vegetable",
    "Do 10 push-ups"
  ]

  var body: some View {
    ZStack {
      // Background Part
      Rectangle()
        .foregroundColor(.clear)

      VStack {
        // Upper "empty" part
        Spacer()

        // Actual popover part
        VStack {
          Text("Start a new habit!")
            .font(.largeTitle)
            .padding()

          TextFieldUpdated(
            text: $taskName,
            placeholder: "Your new Habit!",
            width: width
          )

          IconGrid(selectedIcon: $selectedIcon, width: width)

          PartOfDayRow(selectedPartOfDay: $selectedPartOfDay)

          WeekdayRow(week: $week)

          PrivacyRow(isPrivate: $isPrivate)

          HStack {
            CancelButton(
              closeOverlay: closeOverlay
            )
            ConfirmTaskButton(
              taskName: taskName,
              startStreak: startStreak,
              selectedIcon: selectedIcon,
              selectedPartOfDay: selectedPartOfDay,
              isPrivate: isPrivate,
              week: week,
              addNewTask: addNewTask,
              closeOverlay: closeOverlay
            )
          }
          .padding()
        }
        .frame(
          width: width - .spacing12,
          height: UIScreen.main.bounds.size.height * 0.7,
          alignment: .center
        )
        .backgroundColor(.white)
        .cornerRadius(8, corners: [.topLeft, .topRight])
        .cornerRadius(38, corners: [.bottomLeft, .bottomRight])
        .shadow(color: .black, radius: 10)
        .overlay(
          HandleForOverlay(closeOverlay: closeOverlay),
          alignment: .top
        )
      }

      // Move everything up a bit for
      // the line between the view at
      // the bottom of the screen.
      .offset(y: -4)
      .edgesIgnoringSafeArea(.all)
    }
    .onAppear {
      taskName = exampleTasks.randomElement() ?? ""
    }
    .transition(
      AnyTransition.opacity.combined(with: .move(edge: .bottom))
    )
  }
}

struct CreateNewTaskView_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Rectangle()
        .foregroundColor(.green)
        .edgesIgnoringSafeArea(.all)

      CreateNewTaskView(
        width: .previewWidth,
        addNewTask: { _ in },
        closeOverlay: {}
      )
    }
  }
}
