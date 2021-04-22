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
    .padding()
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
          //streakRow
          IconGrid(selectedIcon: $selectedIcon, width: width)
          partOfDayRow
          HStack {
            cancelButton
            confirmTaskButton
          }
          .padding()
        }
        .frame(width: width - 6, height: UIScreen.main.bounds.size.height * 0.7, alignment: .center)
        .backgroundColor(.white)
        .cornerRadius(54, corners: [.topLeft, .topRight])
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
