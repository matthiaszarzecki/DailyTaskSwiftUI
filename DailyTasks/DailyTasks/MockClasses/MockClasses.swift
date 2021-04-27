//
//  MockClasses.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 13.04.21.
//

import Foundation

class MockClasses {
  static let task01 = Task(
    name: "Drink water",
    status: false,
    iconName: "drop",
    currentStreak: 2,
    highestStreak: 4,
    partOfDay: 0
  )
  
  static let task02 = Task(
    name: "Go for a walk",
    status: true,
    iconName: "drop",
    currentStreak: 1,
    highestStreak: 0,
    partOfDay: 1
  )
  
  static let task03 = Task(
    name: "Eat an apple",
    status: false,
    iconName: "drop",
    currentStreak: 14,
    highestStreak: 167,
    partOfDay: 3
  )
  
  static let task04 = Task(
    name: "Do sit-ups",
    status: true,
    iconName: "drop",
    currentStreak: 68,
    highestStreak: 68,
    partOfDay: 4
  )
  
  static let task05 = Task(
    name: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
    status: true,
    iconName: "drop",
    currentStreak: 68,
    highestStreak: 68,
    partOfDay: 4
  )
  
  static let tasks = [task01, task02, task03, task04, task05]
}
