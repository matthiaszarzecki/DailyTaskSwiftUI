//
//  Task.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 13.04.21.
//

import Foundation

struct Task: Codable, Identifiable, Hashable {
  var id = UUID()

  var name: String
  var status: Bool
  var iconName: String
  var currentStreak: Int
  var highestStreak: Int

  /// The time of day this task is supposed to be done.
  /// 0 - Morning
  /// 1 - Daytime
  /// 2 - Evening
  /// 3 - All Day
  var partOfDay: Int
}

extension Task {
  static let mockTask01 = Task(
    name: "Drink water",
    status: false,
    iconName: "hare",
    currentStreak: 2,
    highestStreak: 4,
    partOfDay: 0
  )

  static let mockTask02 = Task(
    name: "Go for a walk",
    status: true,
    iconName: "hare",
    currentStreak: 1,
    highestStreak: 0,
    partOfDay: 1
  )

  static let mockTask03 = Task(
    name: "Eat an apple",
    status: false,
    iconName: "hare",
    currentStreak: 14,
    highestStreak: 167,
    partOfDay: 3
  )

  static let mockTask04 = Task(
    name: "Do sit-ups",
    status: true,
    iconName: "hare",
    currentStreak: 68,
    highestStreak: 68,
    partOfDay: 4
  )

  static let mockTask05 = Task(
    name: """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor \
    incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud \
    exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat
    """,
    status: true,
    iconName: "drop",
    currentStreak: 1,
    highestStreak: 68,
    partOfDay: 4
  )
}

extension Array where Element == Task {
  static let mockTasks: [Task] = [.mockTask01, .mockTask02, .mockTask03, .mockTask04, .mockTask05]
}
