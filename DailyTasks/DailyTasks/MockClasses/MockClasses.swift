//
//  MockClasses.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 13.04.21.
//

import Foundation

struct MockClasses {
  static let task01 = Task(
    name: "Drink water",
    status: false
  )
  
  static let task02 = Task(
    name: "Go for a walk",
    status: true
  )
  
  static let task03 = Task(
    name: "Eat an apple",
    status: false
  )
  
  static let task04 = Task(
    name: "Do sit-ups",
    status: true
  )
  
  static let tasks = [task01, task02, task03, task04]
}
