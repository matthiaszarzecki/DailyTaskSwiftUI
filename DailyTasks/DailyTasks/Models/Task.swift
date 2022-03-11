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
