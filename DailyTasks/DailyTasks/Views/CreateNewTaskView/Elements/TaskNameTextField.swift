//
//  TaskNameTextField.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 23.04.21.
//

import SwiftUI

struct TaskNameTextField: View {
  @Binding var taskName: String
  var width: CGFloat

  var body: some View {
    ZStack {
      ZStack {
        Rectangle()
          .foregroundColor(.gray)
        
        TextField("Your new task!", text: $taskName)
          .frame(width: width - 24*2, height: 48, alignment: .center)
          .foregroundColor(.white)
      }
      .frame(width: width - 16*2, height: 48, alignment: .center)
      .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
      
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
}

struct TaskNameTextField_Previews: PreviewProvider {
  static var previews: some View {
    TaskNameTextField(
      taskName: .constant("Hello!"),
      width: PreviewConstants.width
    )
    .padding()
    .previewLayout(.sizeThatFits)
  }
}
