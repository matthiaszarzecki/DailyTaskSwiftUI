//
//  PartOfDayOption.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 21.04.21.
//

import Foundation

struct PartOfDayOption: Hashable {
  let index: Int
  let name: String

  enum DaytimeOptions {
    static let morning = "Morning"
    static let daytime = "Daytime"
    static let evening = "Evening"
    static let allDay = "All Day"
  }

  static func displayString(id: Int) -> String {
    switch id {
    case 0:
      return DaytimeOptions.morning
    case 1:
      return DaytimeOptions.daytime
    case 2:
      return DaytimeOptions.evening
    case 3:
      return DaytimeOptions.allDay
    default:
      return DaytimeOptions.allDay
    }
  }

  static let options = [
    PartOfDayOption(index: 0, name: DaytimeOptions.morning),
    PartOfDayOption(index: 1, name: DaytimeOptions.daytime),
    PartOfDayOption(index: 2, name: DaytimeOptions.evening),
    PartOfDayOption(index: 3, name: DaytimeOptions.allDay)
  ]
}
