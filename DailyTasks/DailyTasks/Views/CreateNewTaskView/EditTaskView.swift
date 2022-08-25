//
//  UpdateTaskView.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 06.06.21.
//

import SwiftUI

struct EditTaskView: View {
  var width: CGFloat
  @State var task: Task
  var editTask: (_ task: Task) -> Void
  var deleteSingleTask: (_ id: UUID) -> Void
  var closeOverlay: () -> Void

  @State private var showActualDeleteButton = false

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
          Text("Change Habit")
            .font(.largeTitle)
            .padding()

          TextFieldUpdated(
            text: $task.name,
            placeholder: task.name,
            width: width
          )

          IconGrid(selectedIcon: $task.iconName, width: width)

          PartOfDayRow(selectedPartOfDay: $task.partOfDay)

          PrivacyRow(isPrivate: $task.isPrivate)

          HStack {
            Button(
              action: {
                withAnimation {
                  showActualDeleteButton = true
                }
              },
              label: {
                Text("Delete Habit")
                  .padding()
                  .backgroundColor(.red)
                  .foregroundColor(.white)
                  .mask(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                  )
                  .shadow(radius: 10)
              }
            )

            if showActualDeleteButton {
              Button(
                action: {
                  deleteSingleTask(task.id)
                  closeOverlay()
                },
                label: {
                  Text("Confirm")
                    .padding()
                    .backgroundColor(.red)
                    .foregroundColor(.white)
                    .mask(
                      RoundedRectangle(cornerRadius: 10, style: .continuous)
                    )
                    .shadow(radius: 10)
                }
              )
            }
          }

          HStack {
            CancelButton(
              closeOverlay: closeOverlay
            )

            Button(
              action: {
                editTask(task)
                closeOverlay()
              },
              label: {
                Text("Confirm Changes")
                  .padding()
                  .backgroundColor(.dailyHabitsGreen)
                  .foregroundColor(.white)
                  .mask(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                  )
                  .shadow(radius: 10)
              }
            )
          }
          .padding()
        }
        .frame(
          width: width,
          height: UIScreen.main.bounds.size.height * 0.6,
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
    .transition(AnyTransition.opacity.combined(with: .move(edge: .bottom)))
  }
}

struct UpdateTaskView_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Rectangle()
        .foregroundColor(.green)
        .edgesIgnoringSafeArea(.all)

      EditTaskView(
        width: PreviewConstants.width,
        task: .mockTask01,
        editTask: { _ in },
        deleteSingleTask: { _ in },
        closeOverlay: {}
      )
    }
  }
}
