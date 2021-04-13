//
//  Task.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 13.04.21.
//

import Foundation

struct Task: Codable, Identifiable, Hashable {
  var id = UUID()
  let name: String
  let status: Bool
}
