//
//  TaskCell.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 15.04.21.
//

import SwiftUI

struct TaskCell: View {
  let task: Task
  
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
            .foregroundColor(.white)
            .padding(6)
            .backgroundColor(.green)
            .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
        } else {
          Image(systemName: "circle")
            .foregroundColor(.gray)
            .padding(6)
            .backgroundColor(.gray)
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
