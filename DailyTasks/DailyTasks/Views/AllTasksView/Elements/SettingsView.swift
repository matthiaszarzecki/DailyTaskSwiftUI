//
//  SettingsView.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 17.04.21.
//

import SwiftUI

struct SettingsView: View {
  @Binding var showCreateTaskView: Bool
  var width: CGFloat
  var addNewTask: (_ name: String) -> Void
  
  @State private var taskName = ""
  
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
        addNewTask(taskName)
        withAnimation {
          showCreateTaskView = false
        }
      },
      label: {
        Text("Go Back")
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
        Text("Actions")
        Text("Delete All Tasks")
        Text("Reset All Tasks")
        confirmTaskButton
      }
      .frame(width: width - 32*2, height: 400, alignment: .center)
      .padding()
      .backgroundColor(.white)
      .cornerRadius(12)
      .shadow(radius: 10)
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView(
      showCreateTaskView: .constant(false),
      width: PreviewConstants.width,
      addNewTask: {_ in }
    )
    .previewLayout(.sizeThatFits)
    .backgroundColor(.green)
  }
}
