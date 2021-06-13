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
  var updateTask: (_ id: UUID) -> Void
  var setOffset: (_ index: Int, _ offset: CGFloat) -> Void
  @Binding var showUpdateTaskPopover: Bool
  @Binding var currentlyEditedTaskIndex: Int
  
  @GestureState var isDragging = false

  var body: some View {
    return List {
      ForEach(tasks.indices, id: \.self) { index in
        ZStack {
          // Revealed through dragging
          //Color(.red)

          //Color(.green)
          //.padding(.trailing, 65)

          HStack {
            Spacer()
            Button(action: {
              print("1. offset: \(offsets[index])")
              self.currentlyEditedTaskIndex = index
              withAnimation {
                showUpdateTaskPopover = true
              }
            }) {
              Image(systemName: "suit.heart")
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 65)
                .backgroundColor(.blue)
            }

            Button(action: {
              print("2. offset: \(offsets[index])")
            }) {
              Image(systemName: "cart.badge.plus")
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 65)
                .backgroundColor(.green)
            }
          }

          Button(
            action: {
              updateTask(tasks[index].id)
            },
            label: {
              TaskCell(task: tasks[index])
            }
          )
          // Disable button when currently slid out
          .disabled(offsets[index] < -125)
          .backgroundColor(.white)

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
      }
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
      offsets: [],
      editTask: {_ in },
      updateTask: {_ in },
      setOffset: {_,_  in },
      showUpdateTaskPopover: .constant(false),
      currentlyEditedTaskIndex: .constant(0)
    )
  }
}
