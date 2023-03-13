//
//  TaskCell.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 15.04.21.
//

import SwiftUI

struct TaskCell: View {
  let task: Task
  let isLastCellToBeShown: Bool
  let height: CGFloat

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
    let daysAfterDangerStartsAfterStreakBreaking = 10

    // e.g. 10 days - ratio of 0.1. 100 days - 0.01
    let dangerRatio = 1.0 / Double(daysAfterDangerStartsAfterStreakBreaking)
    return ratio < dangerRatio
  }

  private var taskIcon: some View {
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

  @ViewBuilder
  private var statusIcon: some View {
    if task.status {
      Image(systemName: "checkmark")
        .frame(width: iconSize, height: iconSize, alignment: .center)
        .foregroundColor(.white)
        .backgroundColor(.dailyHabitsGreen)
        .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
    } else {
      Rectangle()
        .frame(width: iconSize, height: iconSize, alignment: .center)
        .foregroundColor(.dailyHabitsGray)
        .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
  }

  private var emptyPlaceholderToAnchorOverlaysOn: some View {
    Rectangle()
      .frame(width: iconSize, height: iconSize, alignment: .center)
      .foregroundColor(.clear)
  }

  private var privacyIcon: some View {
    Group {
      if task.isPrivate {
        Image(systemName: "eye.slash")
          .font(.system(size: 14))
          .foregroundColor(.dailyHabitsGreen)
      }
    }
  }

  private var cellBody: some View {
    VStack(spacing: 0) {
      HStack(spacing: 12) {
        emptyPlaceholderToAnchorOverlaysOn

        if task.status {
          Text(task.name)
            .foregroundColor(.dailyHabitsGreen)
            .strikethrough()
            .minimumScaleFactor(0.7)
        } else {
          Text(task.name)
            .minimumScaleFactor(0.7)
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
      .padding(.bottom, .spacing4)

      TaskStatistics(task: task)
        .overlay(
          privacyIcon,
          alignment: .bottomTrailing
        )
    }
    .padding(
      EdgeInsets(
        top: .spacing12,
        leading: .spacing8,
        bottom: .spacing12,
        trailing: .spacing8
      )
    )
    .background(
      Image(backgroundName)
        .resizable(resizingMode: .tile)
    )
    .frame(height: height)
    .cornerRadius(12, corners: [.topRight, .bottomRight])
  }

  var body: some View {
    if isLastCellToBeShown {
      cellBody
        .cornerRadius(12, corners: [.bottomLeft])
    } else {
      cellBody
    }
  }
}

struct TaskCell_Previews: PreviewProvider {
  static var previews: some View {
    let configurations: [(task: Task, isLastCellToBeShown: Bool, displayName: String)] = [
      (.mockTask01, false, "Todo"),
      (.mockTask02, false, "Done"),
      (.mockTask05, false, "Danger Done"),
      (.mockTask05, true, "Last Cell")
    ]

    ForEach(0..<configurations.count, id: \.self) { index in
      let configuration = configurations[index]
      TaskCell(
        task: configuration.task,
        isLastCellToBeShown: configuration.isLastCellToBeShown,
        height: 74
      )
      .padding()
      .backgroundColor(.purple)
      .previewLayout(.sizeThatFits)
      .previewDisplayName(configuration.displayName)
    }
  }
}
