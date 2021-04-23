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
    ZStack {
      TextField("Your new task!", text: $taskName)
        .frame(width: width - 16*2, height: 48, alignment: .center)
        .backgroundColor(.gray)
        .foregroundColor(.white)
        .cornerRadius(8.0)
      
      HStack {
        Spacer()
        Button(
          action: {
            taskName = ""
          }, label: {
            Image(systemName: "xmark.circle.fill")
              .foregroundColor(.white)
              .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 8))
          }
        )
      }
    }
    .padding()
    .frame(width: width - 16*2, height: 48, alignment: .center)
  }

  var body: some View {
    ZStack {
      // Background Part
      Rectangle()
        .foregroundColor(.clear)
        .edgesIgnoringSafeArea(.all)
      
      VStack {
        // Upper "empty" part
        Spacer()
        
        // Actual popover part
        VStack {
          Text("Create a new task!")
            .font(.largeTitle)
            .padding()
          taskTextfield
          IconGrid(selectedIcon: $selectedIcon, width: width)
          PartOfDayRow(selectedPartOfDay: $selectedPartOfDay)
          HStack {
            cancelButton
            confirmTaskButton
          }
          .padding()
        }
        .frame(width: width - 6, height: UIScreen.main.bounds.size.height * 0.7, alignment: .center)
        .backgroundColor(.white)
        .cornerRadius(54, corners: [.topLeft, .topRight])
        .cornerRadius(46, corners: [.bottomLeft, .bottomRight])
        .shadow(radius: 6)
      }
      .edgesIgnoringSafeArea(.all)
    }
    .transition(.move(edge: .bottom))
    .onAppear {
      taskName = exampleTasks.randomElement() ?? ""
    }
  }
}

struct CreateNewTaskView_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Rectangle()
        .foregroundColor(.green)
        .edgesIgnoringSafeArea(.all)
      
      CreateNewTaskView(
        showCreateTaskView: .constant(false),
        width: PreviewConstants.width,
        addNewTask: {_ in }
      )
    }
  }
}
