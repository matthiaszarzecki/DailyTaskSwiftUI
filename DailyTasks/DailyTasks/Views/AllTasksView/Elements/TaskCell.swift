//
//  TaskCell.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 15.04.21.
//

import SwiftUI

struct TaskCell: View {
  let task: Task
  
  private let iconSize: CGFloat = 30
  
  var body: some View {
    VStack {
      HStack {
        Image(systemName: task.iconName)
        
        if task.status {
          Text("\(task.name)")
            .strikethrough()
        } else {
          Text("\(task.name)")
        }
        
        Spacer()
        
        if task.status {
          Image(systemName: "checkmark")
            .frame(width: iconSize, height: iconSize, alignment: .center)
            .foregroundColor(.white)
            .backgroundColor(.dailyHabitsGreen)
            .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
        } else {
          Rectangle()
            .frame(width: iconSize, height: iconSize, alignment: .center)
            .foregroundColor(.dailyHabitsGray)
            .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
        } 
      }
      
      HStack {
        Text("Days in a row: \(task.currentStreak) - Record: \(task.highestStreak) - Part of day: \(task.partOfDay)")
          .font(.footnote)
        
        Spacer()
      }
    }
  }
}

struct TaskCell_Previews: PreviewProvider {
  static var previews: some View {
    TaskCell(task: MockClasses.task01)
      .padding()
      .previewLayout(.sizeThatFits)
    
    TaskCell(task: MockClasses.task02)
      .padding()
      .previewLayout(.sizeThatFits)
  }
}
