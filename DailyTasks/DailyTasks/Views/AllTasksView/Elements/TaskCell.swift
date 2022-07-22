//
//  TaskCell.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 15.04.21.
//

import SwiftUI

struct TaskCell: View {
  let task: Task

  private let iconSize: CGFloat = 30

  private var backgroundName: String {
    if task.partOfDay == 0 {
      return "background_morning"
    } else if task.partOfDay == 1 {
      return "background_daytime"
    } else if task.partOfDay == 2 {
      return "background_evening"
    } else {
      return "background_all_day"
    }
  }

  private var danger: Bool {
    let ratio = Double(task.currentStreak) / Double(task.highestStreak)
    let daysAfterWhichDangerStartsAfterStreakBreaking = 10

    // e.g. 10 days - ratio of 0.1. 100 days - 0.01
    let dangerRatio = 1.0 / Double(daysAfterWhichDangerStartsAfterStreakBreaking)
    return ratio < dangerRatio
  }

  var taskIcon: some View {
    // When a long-running task has been
    // failed recently, color the icon red.
    let color: Color = danger ? .red : .gray

    return Image(systemName: task.iconName)
      .font(.system(size: 14))
      .frame(width: iconSize, height: iconSize, alignment: .center)
      .backgroundColor(color)
      .foregroundColor(.white)
      .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
  }

  var statusIcon: some View {
    if task.status {
      return AnyView(
        Image(systemName: "checkmark")
          .frame(width: iconSize, height: iconSize, alignment: .center)
          .foregroundColor(.white)
          .backgroundColor(.dailyHabitsGreen)
          .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
      )
    } else {
      return AnyView(
        Rectangle()
          .frame(width: iconSize, height: iconSize, alignment: .center)
          .foregroundColor(.dailyHabitsGray)
          .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
      )
    }
  }

  var emptyPlaceholderToAnchorOverlaysOn: some View {
    Rectangle()
      .frame(width: iconSize, height: iconSize, alignment: .center)
      .foregroundColor(.clear)
  }

  var body: some View {
    VStack(spacing: 0) {
      HStack(spacing: 12) {
        emptyPlaceholderToAnchorOverlaysOn

        if task.status {
          Text(task.name)
            .foregroundColor(.dailyHabitsGreen)
            .strikethrough()
        } else {
          Text(task.name)
        }

        Spacer()

        emptyPlaceholderToAnchorOverlaysOn
      }
      .overlay(
        taskIcon,
        alignment: .topLeading
      )
      .overlay(
        statusIcon,
        alignment: .topTrailing
      )
      .padding(.bottom, 4)
      .padding(.trailing, 8)

      TaskStatistics(task: task)
    }
    .padding(.top, 4)
    .padding(.bottom, 4)
    .cornerRadius(12, corners: [.topRight, .bottomRight])
    .padding(8)
    .background(
      Image(backgroundName)
        .resizable(resizingMode: .tile)
    )
  }
}

struct TaskCell_Previews: PreviewProvider {
  static var previews: some View {
    TaskCell(task: MockClasses.task01)
      .padding()
      .backgroundColor(.purple)
      .previewLayout(.sizeThatFits)

    TaskCell(task: MockClasses.task02)
      .padding()
      .backgroundColor(.purple)
      .previewLayout(.sizeThatFits)

    TaskCell(task: MockClasses.task05)
      .padding()
      .backgroundColor(.purple)
      .previewLayout(.sizeThatFits)
  }
}
