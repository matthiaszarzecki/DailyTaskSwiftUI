//
//  TaskList.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 07.06.21.
//

import SwiftUI

struct TaskList: View {
  var tasks: [Task]
  var offsets: [CGFloat]
  var editTask: (_ task: Task) -> Void
  var toggleTaskAsDone: (_ id: UUID) -> Void
  var setOffset: (_ index: Int, _ offset: CGFloat) -> Void
  @Binding var showUpdateTaskPopover: Bool
  @Binding var currentlyEditedTaskIndex: Int
  
  @GestureState var isDragging = false
  
  var greenCellBackground: some View {
    // Revealed through dragging
    Color.dailyHabitsGreen
      .mask(RoundedRectangle(cornerRadius: 12, style: .continuous))
  }
  
  var editTaskButton: some View {
    VStack {
      Image(systemName: "gear")
        .font(.title)
        .foregroundColor(.white)
      Text("Edit")
        .foregroundColor(.white)
        .font(.footnote)
    }
  }
  
  var body: some View {
    return List {
      ForEach(tasks.indices, id: \.self) { index in
        ZStack {
          greenCellBackground
          
          HStack {
            Spacer()
            Button(
              action: {
                editTaskClicked(index: index)
              },
              label: {
                editTaskButton
              }
            )
            .frame(width: 130)
            // Only enable button once fully slid out
            .disabled(offsets[index] > -125)
          }
          
          Button(
            action: {
              // Only allow action when cell is not slid out.
              // Using .disable is causing issues with transparency.
              if offsets[index] == 0 {
                toggleTaskAsDone(tasks[index].id)
              }
            },
            label: {
              TaskCell(task: tasks[index])
            }
          )
          .buttonStyle(.plain)
          
          // Drag Gesture Handling
          .offset(x: offsets[index])
          
          .gesture(
            DragGesture(minimumDistance: 30, coordinateSpace: .local)
              .updating(
                $isDragging,
                body: { (value, state, _) in
                  // so we can validate for correct drag
                  state = true
                  onChanged(value: value, index: index)
                }
              )
              .onEnded(
                { (value) in
                  onEnded(value: value, index: index)
                }
              )
          )
        }
        // Smaller padding on the right to make sliding look nicer
        .listRowInsets(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 4))
      }
      
      // Spacer to be able to scroll the
      // list above the overlay buttons
      Rectangle()
        .foregroundColor(.clear)
        .frame(width: 200, height: 66, alignment: .center)
    }
  }
  
  func editTaskClicked(index: Int) {
    print("1. offset: \(offsets[index])")
    self.currentlyEditedTaskIndex = index
    withAnimation {
      showUpdateTaskPopover = true
    }
  }
  
  func onChanged(value: DragGesture.Value, index: Int) {
    if value.translation.width < 0 {
      setOffset(index, value.translation.width)
    }
  }
  
  func onEnded(value: DragGesture.Value, index: Int) {
    withAnimation {
      if -value.translation.width >= 100 {
        setOffset(index, -130)
      } else {
        setOffset(index, 0)
      }
    }
  }
}

struct TaskList_Previews: PreviewProvider {
  static var previews: some View {
    TaskList(
      tasks: MockClasses.tasks,
      // Offsets MUST be the same length as tasks
      offsets: [0, 0, -130, -130, 0],
      editTask: {_ in },
      toggleTaskAsDone: {_ in },
      setOffset: {_,_  in },
      showUpdateTaskPopover: .constant(false),
      currentlyEditedTaskIndex: .constant(0)
    )
  }
}
