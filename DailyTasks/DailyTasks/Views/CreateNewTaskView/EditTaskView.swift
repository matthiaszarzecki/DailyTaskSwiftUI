//
//  UpdateTaskView.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 06.06.21.
//

import SwiftUI

struct EditTaskView: View {
  var width: CGFloat
  @State var task: Task
  var editTask: (_ task: Task) -> Void
  var closeOverlay: () -> Void

  //@State private var taskName = "New Task!"
  //@State private var startStreak = "0"
  @State private var selectedPartOfDay = 1
  @State private var selectedIcon = "drop"
  
  var body: some View {
    ZStack {
      // Background Part
      Rectangle()
        .foregroundColor(.clear)

      VStack {
        // Upper "empty" part
        Spacer()
        
        // Actual popover part
        VStack {
          Text("Edit Habit")
            .font(.largeTitle)
            .padding()
          
          TextFieldUpdated(
            text: $task.name,
            placeholder: "Your new Habit!",
            width: width
          )
          
          IconGrid(selectedIcon: $selectedIcon, width: width)

          PartOfDayRow(selectedPartOfDay: $selectedPartOfDay)
          
          HStack {
            CancelButton(
              closeOverlay: closeOverlay
            )
            
            Button(
              action: {
                editTask(task)
                closeOverlay()
              },
              label: {
                Text("OK")
                  .padding()
                  .backgroundColor(.dailyHabitsGreen)
                  .foregroundColor(.white)
                  .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
                  .shadow(radius: 10)
              }
            )
            
          }
          .padding()
        }
        .frame(width: width - 12, height: UIScreen.main.bounds.size.height * 0.6, alignment: .center)
        .backgroundColor(.white)
        .cornerRadius(8, corners: [.topLeft, .topRight])
        .cornerRadius(38, corners: [.bottomLeft, .bottomRight])
        .shadow(color: .black, radius: 10)
        .overlay(
          HandleForOverlay(closeOverlay: closeOverlay),
          alignment: .top
        )
      }
      
      // Move everything up a bit for
      // the line between the view at
      // the bottom of the screen.
      .offset(y: -4)
      .edgesIgnoringSafeArea(.all)
    }
    .transition(AnyTransition.opacity.combined(with: .move(edge: .bottom)))
  }
}

struct UpdateTaskView_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Rectangle()
        .foregroundColor(.green)
        .edgesIgnoringSafeArea(.all)
      
      EditTaskView(
        width: PreviewConstants.width,
        task: MockClasses.task01,
        editTask: { _ in },
        closeOverlay: {}
      )
    }
  }
}
