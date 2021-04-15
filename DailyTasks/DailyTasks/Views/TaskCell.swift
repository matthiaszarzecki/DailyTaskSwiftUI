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
    HStack {
      Text("\(task.name)")
      
      if task.status {
        Image(systemName: "checkmark")
          .foregroundColor(.green)
      } else {
        Image(systemName: "circle")
      }
    }
  }
}

struct TaskCell_Previews: PreviewProvider {
  static var previews: some View {
    TaskCell(task: MockClasses.task01)
      .padding()
      .previewLayout(.sizeThatFits)
  }
}
