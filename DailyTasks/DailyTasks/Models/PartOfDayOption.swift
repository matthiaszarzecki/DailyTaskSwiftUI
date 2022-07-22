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

  enum daytimeOptions {
    static let morning = "Morning"
    static let daytime = "Daytime"
    static let evening = "Evening"
    static let allDay = "All Day"
  }

  static func displayString(id: Int) -> String {
    switch id {
    case 0:
      return daytimeOptions.morning
    case 1:
      return daytimeOptions.daytime
    case 2:
      return daytimeOptions.evening
    case 3:
      return daytimeOptions.allDay
    default:
      return daytimeOptions.allDay
    }
  }

  static let options = [
    PartOfDayOption(index: 0, name: daytimeOptions.morning),
    PartOfDayOption(index: 1, name: daytimeOptions.daytime),
    PartOfDayOption(index: 2, name: daytimeOptions.evening),
    PartOfDayOption(index: 3, name: daytimeOptions.allDay)
  ]
}
