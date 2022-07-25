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

  @GestureState private var isDragging = false
  private let maxDragDistance: CGFloat = 130

  private var greenCellBackground: some View {
    // Revealed through dragging
    Color.dailyHabitsGreen
      .mask(RoundedRectangle(cornerRadius: 12, style: .continuous))
  }

  private var editTaskButton: some View {
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
    List {
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
            .frame(width: maxDragDistance)

            // Only enable button once fully slid out
            .disabled(offsets[index] > -(maxDragDistance - 5))
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
          .accentColor(.black)

          // Drag Gesture Handling
          .offset(x: offsets[index])

          .gesture(
            DragGesture(
              minimumDistance: 30,
              coordinateSpace: .local
            )
            .updating($isDragging) { value, state, _ in
              // so we can validate for correct drag
              state = true
              onChanged(value: value, index: index)
            }
            .onEnded { value in
              onEnded(value: value, index: index)
            }
          )
        }

        // No Auto-Insets
        .listRowInsets(
          EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        )
      }

      // Spacer to be able to scroll the list above the overlay buttons.
      // The ZStack with 0 edgeinsets allows to use the whole cell
      ZStack {
        Color.backgroundGray
          .frame(height: 100)
      }
      .listRowInsets(
        EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
      )
    }
  }

  private func editTaskClicked(index: Int) {
    print("1. offset: \(offsets[index])")
    self.currentlyEditedTaskIndex = index
    withAnimation {
      showUpdateTaskPopover = true
    }
  }

  private func onChanged(value: DragGesture.Value, index: Int) {
    if value.translation.width < 0 {
      setOffset(index, value.translation.width)
    }
  }

  private func onEnded(value: DragGesture.Value, index: Int) {
    withAnimation {
      // Once offset is close to the left max value move it to max directly
      let offset: CGFloat = -value.translation.width >= (maxDragDistance - 30)
        ? -maxDragDistance
        : 0
      setOffset(index, offset)
    }
  }
}

struct TaskList_Previews: PreviewProvider {
  static var previews: some View {
    let maxDragDistance: CGFloat = 130

    TaskList(
      tasks: .mockTasks,
      // Offsets array MUST be the same length as tasks
      offsets: [0, 0, -maxDragDistance, -maxDragDistance, 0],
      editTask: { _ in },
      toggleTaskAsDone: { _ in },
      setOffset: { _, _  in },
      showUpdateTaskPopover: .constant(false),
      currentlyEditedTaskIndex: .constant(0)
    )
  }
}
