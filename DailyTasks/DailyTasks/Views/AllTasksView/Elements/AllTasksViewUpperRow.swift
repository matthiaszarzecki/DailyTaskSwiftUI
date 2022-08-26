//
//  AllTasksViewUpperRow.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 23.04.21.
//

import SwiftUI

struct AllTasksViewUpperRow: View {
  var tasks: [Task]
  var width: CGFloat
  var height: CGFloat = 128
  @Binding var showSettingsPopover: Bool
  @Binding var userName: String
  var isPrivacyEnabled: Bool

  private var doneTasks: Int {
    let doneTasks = tasks.filter { $0.status }
    return doneTasks.count
  }

  private var allTasks: Int {
    tasks.count
  }

  private var taskDoneRatio: Double {
    tasks.isEmpty
      ? 0.0
      : Double(doneTasks) / Double(allTasks)
  }

  private var progressDisplay: some View {
    let displayNumber = taskDoneRatio * 100
    let displayString = String(format: "%.0f", displayNumber)
    return Text("Progress: \(displayString)%")
  }

  var body: some View {
    ZStack {
      Rectangle()
        .edgesIgnoringSafeArea(.all)
        .foregroundColor(.white)
        .shadow(radius: 12)
        .frame(width: width, height: height, alignment: .center)

      VStack {
        HStack {
          if userName.isEmpty {
            Text("Your Daily Habits")
              .frame(width: width * 0.55, height: 24, alignment: .leading)
              .multilineTextAlignment(.leading)
              .font(.system(size: 200))
              .minimumScaleFactor(0.12)
              .padding()
          } else {
            VStack(spacing: 4) {
              Text("Good Morning")
                .frame(width: width * 0.55, height: 14, alignment: .leading)
                .multilineTextAlignment(.leading)
                .font(.system(size: 12))
                .minimumScaleFactor(0.12)

              Text(userName)
                .frame(width: width * 0.55, height: 32, alignment: .leading)
                .font(.system(size: 300))
                .minimumScaleFactor(0.12)
            }
            .padding(EdgeInsets(top: 0, leading: .spacing16, bottom: 0, trailing: .spacing16))
          }

          Spacer()

          if isPrivacyEnabled {
            Image(systemName: "eye.slash")
              .font(.system(size: 26))
              .foregroundColor(.dailyHabitsGreen)
          }

          Button(
            action: {
              withAnimation {
                showSettingsPopover.toggle()
              }
            },
            label: {
              Image(systemName: "person.crop.circle")
                .foregroundColor(.dailyHabitsGreen)
                .font(.system(size: 26))
                .padding()
            }
          )
        }
        .frame(width: width, height: 72, alignment: .center)

        progressDisplay
          .frame(
            width: width - .spacing16 * 2,
            height: 20,
            alignment: .leading
          )

        ProgressBar(
          width: width - .spacing16 * 2,
          value: taskDoneRatio
        )
        .padding(.bottom, .spacing12)
      }
    }
    .frame(width: width, height: height, alignment: .center)
  }
}

struct AllTasksViewUpperRow_Previews: PreviewProvider {
  static var previews: some View {
    AllTasksViewUpperRow(
      tasks: .mockTasks,
      width: PreviewConstants.width,
      showSettingsPopover: .constant(false),
      userName: .constant(MockClasses.userName),
      isPrivacyEnabled: true
    )
    .padding()
    .backgroundColor(.green)
    .previewLayout(.sizeThatFits)

    AllTasksViewUpperRow(
      tasks: .mockTasks,
      width: PreviewConstants.width,
      showSettingsPopover: .constant(false),
      userName: .constant(""),
      isPrivacyEnabled: false
    )
    .padding()
    .backgroundColor(.green)
    .previewLayout(.sizeThatFits)
  }
}
