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
    Button(
      action: {
        let streak = Int(startStreak) ?? 0
        let task = Task(
          name: taskName,
          status: false,
          iconName: "drop",
          currentStreak: streak,
          highestStreak: 0
        )
        
        addNewTask(task)
        withAnimation {
          showCreateTaskView = false
        }
      },
      label: {
        Text("OK")
          .padding()
          .backgroundColor(.green)
          .foregroundColor(.white)
          .cornerRadius(12)
          .shadow(radius: 10)
      }
    )
  }
  
  var taskTextfield: some View {
    TextField("Your new task!", text: $taskName)
      .frame(width: 200, height: 48, alignment: .center)
      .backgroundColor(.gray)
      .foregroundColor(.white)
      .cornerRadius(8.0)
      .padding(.top, 16)
      .padding(.bottom, 16)
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
          
          TextField("Start Streak", text: $startStreak)
            .keyboardType(.numberPad)
            .frame(width: 200, height: 48, alignment: .center)
            .backgroundColor(.gray)
            .foregroundColor(.white)
            .cornerRadius(8.0)
            .padding(.top, 16)
            .padding(.bottom, 16)
          
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
