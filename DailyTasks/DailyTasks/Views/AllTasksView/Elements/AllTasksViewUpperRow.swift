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

  private var doneTasks: Int {
    let doneTasks = tasks.filter { $0.status }
    return doneTasks.count
  }

  private var allTasks: Int {
    return tasks.count
  }

  private var taskDoneRatio: Double {
    if tasks.isEmpty {
      return 0.0
    } else {
      return Double(doneTasks) / Double(allTasks)
    }
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
          if userName == "" {
            Text("Your Daily Habits")
              .frame(width: width - 100, height: 24, alignment: .leading)
              .multilineTextAlignment(.leading)
              .font(.system(size: 200))
              .minimumScaleFactor(0.12)
              .padding()
          } else {
            VStack(spacing: 4) {
              Text("Good Morning")
                .frame(width: width - 100, height: 14, alignment: .leading)
                .multilineTextAlignment(.leading)
                .font(.system(size: 12))
                .minimumScaleFactor(0.12)

              Text("\(userName)")
                .frame(width: width - 100, height: 32, alignment: .leading)
                .font(.system(size: 300))
                .minimumScaleFactor(0.12)
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
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
                .font(.title)
                .padding()
            }
          )
        }

        progressDisplay
          .frame(width: width - 16*2, height: 20, alignment: .leading)

        ProgressBar(
          width: width - 16*2,
          value: taskDoneRatio
        )
        .padding(.bottom, 12)
      }
    }
    .frame(width: width, height: height, alignment: .center)
  }
}

struct AllTasksViewUpperRow_Previews: PreviewProvider {
  static var previews: some View {
    AllTasksViewUpperRow(
      tasks: MockClasses.tasks,
      width: PreviewConstants.width,
      showSettingsPopover: .constant(false),
      userName: .constant(MockClasses.userName)
    )
    .padding()
    .backgroundColor(.green)
    .previewLayout(.sizeThatFits)

    AllTasksViewUpperRow(
      tasks: MockClasses.tasks,
      width: PreviewConstants.width,
      showSettingsPopover: .constant(false),
      userName: .constant("")
    )
    .padding()
    .backgroundColor(.green)
    .previewLayout(.sizeThatFits)
  }
}
