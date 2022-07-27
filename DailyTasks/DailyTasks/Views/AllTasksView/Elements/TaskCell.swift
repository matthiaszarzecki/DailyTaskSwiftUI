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

  private var cellBody: some View {
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
    .padding(EdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8))
    .cornerRadius(12, corners: [.topRight, .bottomRight])
    .background(
      Image(backgroundName)
        .resizable(resizingMode: .tile)
    )
  }

  var body: some View {
    if isLastCellToBeShown {
      cellBody
        .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
    } else {
      cellBody
    }
  }
}

struct TaskCell_Previews: PreviewProvider {
  static var previews: some View {
    let configurations: [(task: Task, isLastCellToBeShown: Bool)] = [
      (.mockTask01, false),
      (.mockTask02, false),
      (.mockTask05, false),
      (.mockTask05, true)
    ]

    ForEach(0..<configurations.count, id: \.self) { index in
      let configuration = configurations[index]
      TaskCell(
        task: configuration.task,
        isLastCellToBeShown: configuration.isLastCellToBeShown
      )
      .padding()
      .backgroundColor(.purple)
      .previewLayout(.sizeThatFits)
    }
  }
}
