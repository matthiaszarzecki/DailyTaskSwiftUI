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
  
  var taskIcon: some View {
    Image(systemName: task.iconName)
      .frame(width: iconSize, height: iconSize, alignment: .center)
      .backgroundColor(.gray)
      .foregroundColor(.white)
      .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
  }
  
  var statusIcon: some View {
    if task.status {
      return AnyView(Image(systemName: "checkmark")
        .frame(width: iconSize, height: iconSize, alignment: .center)
        .foregroundColor(.white)
        .backgroundColor(.dailyHabitsGreen)
        .mask(RoundedRectangle(cornerRadius: 10, style: .continuous)))
    } else {
      return AnyView(Rectangle()
        .frame(width: iconSize, height: iconSize, alignment: .center)
        .foregroundColor(.dailyHabitsGray)
        .mask(RoundedRectangle(cornerRadius: 10, style: .continuous)))
    }
  }
  
  var emptyPlaceholderToAnchorOverlaysOn: some View {
    Rectangle()
      .frame(width: iconSize, height: iconSize, alignment: .center)
      .foregroundColor(.clear)
  }
  
  var body: some View {
    VStack {
      HStack {
        emptyPlaceholderToAnchorOverlaysOn

        if task.status {
          Text("\(task.name)")
            .foregroundColor(.dailyHabitsGreen)
            .strikethrough()
        } else {
          Text("\(task.name)")
        }
        
        Spacer()
        
        emptyPlaceholderToAnchorOverlaysOn
      }
      .overlay(
        taskIcon,
        alignment: .topLeading
      )
      .overlay(
        statusIcon,
        alignment: .topTrailing
      )
      .padding(.bottom, 4)
      
      TaskStatistics(task: task)
    }
    .backgroundColor(.white)
    .mask(RoundedRectangle(cornerRadius: 12, style: .continuous))
  }
}

struct TaskCell_Previews: PreviewProvider {
  static var previews: some View {
    TaskCell(task: MockClasses.task01)
      .padding()
      .backgroundColor(.red)
      .previewLayout(.sizeThatFits)
    
    TaskCell(task: MockClasses.task02)
      .padding()
      .backgroundColor(.red)
      .previewLayout(.sizeThatFits)
      
    TaskCell(task: MockClasses.task05)
      .padding()
      .backgroundColor(.red)
      .previewLayout(.sizeThatFits)
  }
}
