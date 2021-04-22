//
//  CreateNewTaskView.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 15.04.21.
//

import SwiftUI

struct CreateNewTaskView: View {
  @Binding var showCreateTaskView: Bool
  var width: CGFloat
  var addNewTask: (_ task: Task) -> Void
  
  @State private var taskName = "New Task!"
  @State private var startStreak = "0"
  
  private let exampleTasks = ["Drink water", "Go for a walk", "Eat fruit or vegetable", "Go for a run", "Go outside"]
  
  @State private var selectedPartOfDay = 1
  @State private var selectedIcon = "drop"
  
  var cancelButton: some View {
    Button(
      action: {
        withAnimation {
          showCreateTaskView = false
        }
      },
      label: {
        Text("Cancel")
          .padding()
          .backgroundColor(.red)
          .foregroundColor(.white)
          .cornerRadius(12)
          .shadow(radius: 10)
      }
    )
  }
  
  var confirmTaskButton: some View {
    let disabled = taskName.isEmpty
    let color: Color = disabled ? .gray : .green
    
    return Button(
      action: {
        let streak = Int(startStreak) ?? 0
        
        let task = Task(
          name: taskName,
          status: false,
          iconName: selectedIcon,
          currentStreak: streak,
          highestStreak: 0,
          partOfDay: selectedPartOfDay
        )
        
        addNewTask(task)
        withAnimation {
          showCreateTaskView = false
        }
      },
      label: {
        Text("OK")
          .padding()
          .backgroundColor(color)
          .foregroundColor(.white)
          .cornerRadius(12)
          .shadow(radius: 10)
      }
    )
    .disabled(disabled)
  }
  
  var taskTextfield: some View {
    HStack {
      TextField("Your new task!", text: $taskName)
        .frame(width: 200, height: 48, alignment: .center)
        .backgroundColor(.gray)
        .foregroundColor(.white)
        .cornerRadius(8.0)
        .padding(.top, 16)
        .padding(.bottom, 16)
      
      Button(
        action: {
          taskName = ""
        }, label: {
          Image(systemName: "xmark.circle.fill")
        }
      )
    }
  }
  
  var streakRow: some View {
    HStack {
      TextField("Start Streak", text: $startStreak)
        .keyboardType(.numberPad)
        .frame(width: 200, height: 48, alignment: .center)
        .backgroundColor(.gray)
        .foregroundColor(.white)
        .cornerRadius(8.0)
        .padding(.top, 16)
        .padding(.bottom, 16)
      
      Button(
        action: {
          startStreak = ""
        }, label: {
          Image(systemName: "xmark.circle.fill")
        }
      )
    }
  }
  
  var partOfDayRow: some View {
    HStack {
      let partOfDayOptions = [
        PartOfDayOption(index: 0, name: "Morning"),
        PartOfDayOption(index: 1, name: "Daytime"),
        PartOfDayOption(index: 2, name: "Evening"),
        PartOfDayOption(index: 3, name: "All Day")
      ]
      let padding: CGFloat = 6
      
      ForEach(partOfDayOptions, id: \.self) { option in
        if selectedPartOfDay == option.index {
          Text("\(option.name)")
            .padding(padding)
            .backgroundColor(.white)
            .foregroundColor(.gray)
            .overlay(
              RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 2)
            )
        } else {
          Button(
            action: {
              selectedPartOfDay = option.index
            },
            label: {
              Text("\(option.name)")
                .padding(padding)
                .backgroundColor(.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
          )
        }
      }
    }
  }
  
  var iconRow: some View {
    let iconOptions = [
      "drop",
      "applewatch",
      "pencil",
      "folder",
      "eye",
      "message",
      "guitars",
      "chevron.left.slash.chevron.right"/*,
      "hare",
      "snow"*/
    ]
    let iconSize: CGFloat = 40
    let padding: CGFloat = 10
    let cellWidthSmall: CGFloat = 33
    let column = GridItem(.fixed(cellWidthSmall), spacing: padding, alignment: .leading)
    let gridItems = [column, column, column, column, column, column]
    
    return LazyVGrid(columns: gridItems, spacing: padding) {
      ForEach(iconOptions, id: \.self) { option in
        if selectedIcon == option {
          Image(systemName: option)
            .frame(width: iconSize, height: iconSize, alignment: .center)
            .backgroundColor(.white)
            .foregroundColor(.gray)
            .overlay(
              RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 2)
            )
        } else {
          Button(
            action: {
              selectedIcon = option
            },
            label: {
              Image(systemName: option)
                .frame(width: iconSize, height: iconSize, alignment: .center)
                .backgroundColor(.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
          )
        }
      }
    }
    .frame(width: 330)
  }
  
  var body: some View {
    ZStack {
      Rectangle()
        .foregroundColor(.clear)
      
      VStack {
        Spacer()
        
        VStack {
          Text("Create a new task!")
          taskTextfield
          streakRow
          iconRow
          partOfDayRow
          HStack {
            cancelButton
            confirmTaskButton
          }
        }
        .frame(width: width - 16*2, height: 400, alignment: .center)
        .padding()
        .backgroundColor(.white)
        .cornerRadius(54, corners: [.topLeft, .topRight])
        .shadow(radius: 10)
      }
    }
    .transition(.move(edge: .bottom))
    .onAppear {
      taskName = exampleTasks.randomElement() ?? ""
    }
  }
}

struct CreateNewTaskView_Previews: PreviewProvider {
  static var previews: some View {
    GeometryReader { geometry in
      CreateNewTaskView(
        showCreateTaskView: .constant(false),
        width: geometry.size.width,
        addNewTask: {_ in }
      )
      .backgroundColor(.green)
    }
  }
}
