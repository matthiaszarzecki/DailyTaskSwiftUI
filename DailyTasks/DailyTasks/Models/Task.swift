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
  var partOfDay: Int
}
