//
//  SlidableCell.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 13.08.22.
//

import Foundation
import SwiftUI

struct SlidableCell: View {
  let task: Task
  let isLastCellToBeShown: Bool
  let offset: CGFloat
  let index: Int
  let setOffset: (_ index: Int, _ offset: CGFloat) -> Void
  let editTaskClicked: (_ index: Int) -> Void
  var toggleTaskAsDone: (_ id: UUID) -> Void

  @GestureState private var isDragging = false
  private let maxDragDistance: CGFloat = 130
  private let cellHeight: CGFloat = 74

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

  private var greenCellBackground: some View {
    // Revealed through dragging
    Color.dailyHabitsGreen
      .mask(RoundedRectangle(cornerRadius: 12, style: .continuous))
      .backgroundColor(.backgroundGray)
      .frame(height: cellHeight)
  }

  var body: some View {
    ZStack {
      // Green Background of Cell
      greenCellBackground

      // Edit-Button, revealed through Dragging
      HStack {
        Spacer()

        Button(
          action: {
            editTaskClicked(index)
          },
          label: {
            editTaskButton
          }
        )
        .frame(width: maxDragDistance)

        // Only enable button once fully slid out
        .disabled(offset > -(maxDragDistance - 5))
      }

      // Actual Task-Cell, can be tapped to toggle task
      Button(
        action: {
          // Only allow action when cell is not slid out.
          // Using .disable is causing issues with transparency.
          if offset == 0 {
            toggleTaskAsDone(task.id)
          }
        },
        label: {
          TaskCell(
            task: task,
            isLastCellToBeShown: isLastCellToBeShown,
            height: cellHeight
          )
        }
      )
      .accentColor(.black)

      // Drag Gesture Handling
      .offset(x: offset)

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

struct SlidableCells_Previews: PreviewProvider {
  static var previews: some View {
    let maxDragDistance: CGFloat = 130

    let configurations: [
      (task: Task, isLastCellToBeShown: Bool, offset: CGFloat)
    ] = [
      (.mockTask01, false, 0),
      (.mockTask02, false, -maxDragDistance),
      (.mockTask05, false, -maxDragDistance),
      (.mockTask05, true, 0)
    ]

    ForEach(0..<configurations.count, id: \.self) { index in
      let configuration = configurations[index]

      SlidableCell(
        task: configuration.task,
        isLastCellToBeShown: configuration.isLastCellToBeShown,
        offset: configuration.offset,
        index: index,
        setOffset: { _, _ in },
        editTaskClicked: { _ in },
        toggleTaskAsDone: { _ in }
      )
      .padding()
      .backgroundColor(.purple)
      .previewLayout(.sizeThatFits)
    }
  }
}
