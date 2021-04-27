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
  
  enum daytimeOptions: String {
    case morning = "Morning"
    case daytime = "Daytime"
    case evening = "Evening"
    case allDay = "All Day"
  }
  
  static func displayString(id: Int) -> String {
    switch(id) {
    case 0:
      return daytimeOptions.morning.rawValue
    case 1:
      return daytimeOptions.daytime.rawValue
    case 2:
      return daytimeOptions.evening.rawValue
    case 3:
      return daytimeOptions.allDay.rawValue
    default:
      return daytimeOptions.allDay.rawValue
    }
  }
  
  static let options = [
    PartOfDayOption(index: 0, name: daytimeOptions.morning.rawValue),
    PartOfDayOption(index: 1, name: daytimeOptions.daytime.rawValue),
    PartOfDayOption(index: 2, name: daytimeOptions.evening.rawValue),
    PartOfDayOption(index: 3, name: daytimeOptions.allDay.rawValue)
  ]
}
