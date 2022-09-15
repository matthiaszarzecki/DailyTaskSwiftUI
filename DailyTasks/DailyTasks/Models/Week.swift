//
//  Week.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 12.09.22.
//

import Foundation

struct Week: Codable, Hashable {
  enum CodingKeys: String, CodingKey {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
  }

  static let fullWeek = Week(
    monday: true,
    tuesday: true,
    wednesday: true,
    thursday: true,
    friday: true,
    saturday: true,
    sunday: true
  )

  var monday: Bool
  var tuesday: Bool
  var wednesday: Bool
  var thursday: Bool
  var friday: Bool
  var saturday: Bool
  var sunday: Bool

  var allDays: [Bool] {
    [monday, tuesday, wednesday, thursday, friday, saturday, sunday]
  }

  init(
    monday: Bool,
    tuesday: Bool,
    wednesday: Bool,
    thursday: Bool,
    friday: Bool,
    saturday: Bool,
    sunday: Bool
  ) {
    self.monday = monday
    self.tuesday = tuesday
    self.wednesday = wednesday
    self.thursday = thursday
    self.friday = friday
    self.saturday = saturday
    self.sunday = sunday
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    if let mondayInStorage = try? container.decode(Bool.self, forKey: .monday) {
      monday = mondayInStorage
    } else {
      monday = true
    }

    if let tuesdayInStorage = try? container.decode(Bool.self, forKey: .tuesday) {
      tuesday = tuesdayInStorage
    } else {
      tuesday = true
    }

    if let wednesdayInStorage = try? container.decode(Bool.self, forKey: .wednesday) {
      wednesday = wednesdayInStorage
    } else {
      wednesday = true
    }

    if let thursdayInStorage = try? container.decode(Bool.self, forKey: .thursday) {
      thursday = thursdayInStorage
    } else {
      thursday = true
    }

    if let fridayInStorage = try? container.decode(Bool.self, forKey: .friday) {
      friday = fridayInStorage
    } else {
      friday = true
    }

    if let saturdayInStorage = try? container.decode(Bool.self, forKey: .saturday) {
      saturday = saturdayInStorage
    } else {
      saturday = true
    }

    if let sundayInStorage = try? container.decode(Bool.self, forKey: .sunday) {
      sunday = sundayInStorage
    } else {
      sunday = true
    }
  }

  static func getDisplayName(index: Int) -> String {
    var returnName = ""

    if index == 0 {
      returnName = "Mo"
    } else if index == 1 {
      returnName = "Tu"
    } else if index == 2 {
      returnName = "We"
    } else if index == 3 {
      returnName = "Th"
    } else if index == 4 {
      returnName = "Fr"
    } else if index == 5 {
      returnName = "Sa"
    } else if index == 6 {
      returnName = "Su"
    }

    return returnName
  }

  mutating func setWeekday(index: Int, status: Bool) {
    if index == 0 {
      monday = status
    } else if index == 1 {
      tuesday = status
    } else if index == 2 {
      wednesday = status
    } else if index == 3 {
      thursday = status
    } else if index == 4 {
      friday = status
    } else if index == 5 {
      saturday = status
    } else if index == 6 {
      sunday = status
    }
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)

    try container.encode(monday, forKey: .monday)
    try container.encode(tuesday, forKey: .tuesday)
    try container.encode(wednesday, forKey: .wednesday)
    try container.encode(thursday, forKey: .thursday)
    try container.encode(friday, forKey: .friday)
    try container.encode(saturday, forKey: .saturday)
    try container.encode(saturday, forKey: .saturday)
  }
}

extension Week {
  static let mockWeek = Week(
    monday: true,
    tuesday: true,
    wednesday: false,
    thursday: true,
    friday: false,
    saturday: false,
    sunday: true
  )
}
