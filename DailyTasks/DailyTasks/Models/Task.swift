//
//  Task.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 13.04.21.
//

import Foundation

struct Task: Codable, Identifiable, Hashable {
  enum CodingKeys: String, CodingKey {
    case name
    case status
    case iconName
    case currentStreak
    case highestStreak
    case partOfDay
    case isPrivate
  }

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

  var isPrivate: Bool

  init(
    name: String,
    status: Bool,
    iconName: String,
    currentStreak: Int,
    highestStreak: Int,
    partOfDay: Int,
    isPrivate: Bool
  ) {
    self.name = name
    self.status = status
    self.iconName = iconName
    self.currentStreak = currentStreak
    self.highestStreak = highestStreak
    self.partOfDay = partOfDay
    self.isPrivate = isPrivate
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    name = try container.decode(String.self, forKey: .name)
    status = try container.decode(Bool.self, forKey: .status)
    iconName = try container.decode(String.self, forKey: .iconName)
    currentStreak = try container.decode(Int.self, forKey: .currentStreak)
    highestStreak = try container.decode(Int.self, forKey: .highestStreak)
    partOfDay = try container.decode(Int.self, forKey: .partOfDay)

    // isPrivate has been added during production, and
    // might not exist. Set default to false in that case.
    if let isPrivateInStorage = try? container.decode(Bool.self, forKey: .isPrivate) {
      isPrivate = isPrivateInStorage
    } else {
      isPrivate = false
    }
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)

    try container.encode(name, forKey: .name)
    try container.encode(status, forKey: .status)
    try container.encode(iconName, forKey: .iconName)
    try container.encode(currentStreak, forKey: .currentStreak)
    try container.encode(highestStreak, forKey: .highestStreak)
    try container.encode(partOfDay, forKey: .partOfDay)
    try container.encode(isPrivate, forKey: .isPrivate)
  }
}

extension Task {
  static let mockTask01 = Task(
    name: "Drink water",
    status: false,
    iconName: "hare",
    currentStreak: 2,
    highestStreak: 4,
    partOfDay: 0,
    isPrivate: false
  )

  static let mockTask02 = Task(
    name: "Go for a walk",
    status: true,
    iconName: "hare",
    currentStreak: 1,
    highestStreak: 0,
    partOfDay: 1,
    isPrivate: false
  )

  static let mockTask03 = Task(
    name: "Eat an apple",
    status: false,
    iconName: "hare",
    currentStreak: 14,
    highestStreak: 167,
    partOfDay: 3,
    isPrivate: false
  )

  static let mockTask04 = Task(
    name: "Do sit-ups",
    status: true,
    iconName: "hare",
    currentStreak: 68,
    highestStreak: 68,
    partOfDay: 4,
    isPrivate: false
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
    partOfDay: 4,
    isPrivate: true
  )
}

extension Array where Element == Task {
  static let mockTasks: [Task] = [.mockTask01, .mockTask02, .mockTask03, .mockTask04, .mockTask05]
}
