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
  @Binding var showSettingsPopover: Bool
  
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
    VStack {
      HStack {
        Text("Your Daily Habits")
          .font(.title)
          .padding()
        
        Spacer()
        
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
    .backgroundColor(.white)
    .shadow(radius: 12)
  }
}

struct AllTasksViewUpperRow_Previews: PreviewProvider {
  static var previews: some View {
    AllTasksViewUpperRow(
      tasks: MockClasses.tasks,
      width: PreviewConstants.width,
      showSettingsPopover: .constant(false)
    )
    .padding()
    .backgroundColor(.green)
    .previewLayout(.sizeThatFits)
  }
}
