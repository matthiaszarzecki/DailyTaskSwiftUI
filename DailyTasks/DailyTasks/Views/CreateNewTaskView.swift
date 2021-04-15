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
  
  @State private var taskName = ""
  
  var cancelButton: some View {
    Button(
      action: {
        showCreateTaskView = false
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
        showCreateTaskView = false
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
    VStack {
      Text("Create a new task!")
      
      taskTextfield
      
      HStack {
        cancelButton
        confirmTaskButton
      }
    }
    .frame(width: width - 16*2, height: 400, alignment: .center)
    .padding()
    .backgroundColor(.white)
    .cornerRadius(12)
    .shadow(radius: 10)
  }
}

struct CreateNewTaskView_Previews: PreviewProvider {
  static var previews: some View {
    CreateNewTaskView(
      showCreateTaskView: .constant(false),
      width: 350
    )
    .padding()
    .previewLayout(.sizeThatFits)
    .backgroundColor(.green)
  }
}
