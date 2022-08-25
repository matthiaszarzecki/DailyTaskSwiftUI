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
  var isPrivacyEnabled: Bool

  var body: some View {
    List {
      ForEach(tasks.indices, id: \.self) { index in
        if isPrivacyEnabled && tasks[index].isPrivate {
          Text("Private Task")
        } else {
          SlidableCell(
            task: tasks[index],
            isLastCellToBeShown: index == tasks.count - 1,
            offset: offsets[index],
            index: index,
            setOffset: setOffset,
            editTaskClicked: editTaskClicked,
            toggleTaskAsDone: toggleTaskAsDone
          )
        }
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
      currentlyEditedTaskIndex: .constant(0),
      isPrivacyEnabled: false
    )
  }
}
