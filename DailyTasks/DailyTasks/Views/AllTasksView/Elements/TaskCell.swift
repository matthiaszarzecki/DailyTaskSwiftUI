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
  
  var body: some View {
    VStack {
      HStack {
        // Empty Placeholder to anchor overlay image on
        Rectangle()
          .frame(width: iconSize, height: iconSize, alignment: .center)
          .foregroundColor(.clear)
        

        if task.status {
          Text("\(task.name)")
            .strikethrough()
        } else {
          Text("\(task.name)")
        }
        
        Spacer()
        
        // Empty Placeholder to anchor overlay image on
        Rectangle()
          .frame(width: iconSize, height: iconSize, alignment: .center)
          .foregroundColor(.clear)
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
      
      HStack {
        let daysInARow = Text("Days in a row: \(task.currentStreak)")
        
        let record = Text(getRecordText(highestStreak: task.highestStreak))
        
        let partOfDay = Text(" - \(PartOfDayOption.displayString(id: task.partOfDay))")
        
        let fullText: Text = daysInARow + record + partOfDay
        fullText
          .font(.footnote)
        
        Spacer()
      }
    }
  }

  func getRecordText(highestStreak: Int) -> String {
    var recordText = ""
    if task.highestStreak > 0 {
      recordText = " - Record: \(highestStreak)"
    }
    return recordText
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
    
    TaskCell(task: MockClasses.task05)
      .padding()
      .previewLayout(.sizeThatFits)
  }
}
