//
//  AllTasksViewLowerRow.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 23.04.21.
//

import SwiftUI

struct AllTasksViewLowerRow: View {
  @Binding var showNewTaskPopover: Bool
  var width: CGFloat
  var height: CGFloat = 72
  var sortTasks: () -> Void
  
  var body: some View {
    ZStack {
      Rectangle()
        .edgesIgnoringSafeArea(.all)
        .foregroundColor(.white)
        .shadow(radius: 12)
        .frame(width: width, height: height, alignment: .center)
      
      HStack {
        Button(
          action: {
            withAnimation {
              showNewTaskPopover = true
            }
          },
          label: {
            HStack {
              Text("New Task")
              Image(systemName: "plus")
            }
            .frame(width: 100, height: 20, alignment: .center)
            .padding()
            .backgroundColor(.dailyHabitsGreen)
            .foregroundColor(.white)
            .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
          }
        )
        
        Button(
          action: {
            withAnimation {
              sortTasks()
            }
          },
          label: {
            HStack {
              Text("Sort")
              Image(systemName: "arrow.up.arrow.down")
            }
            .padding()
            .backgroundColor(.dailyHabitsGreen)
            .foregroundColor(.white)
            .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
          }
        )
      }
    }
  }
}

struct AllTasksViewLowerRow_Previews: PreviewProvider {
  static var previews: some View {
    AllTasksViewLowerRow(
      showNewTaskPopover: .constant(false),
      width: PreviewConstants.width,
      sortTasks: {}
    )
    .padding()
    .backgroundColor(.blue)
    .previewLayout(.sizeThatFits)
  }
}
