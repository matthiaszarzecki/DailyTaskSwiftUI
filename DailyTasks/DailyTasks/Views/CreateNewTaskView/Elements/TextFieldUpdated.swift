//
//  TaskNameTextField.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 23.04.21.
//

import SwiftUI

struct TextFieldUpdated: View {
  @Binding var text: String
  var placeholder: String
  var width: CGFloat

  var body: some View {
    ZStack {
      ZStack {
        Rectangle()
          .foregroundColor(.gray)
        
        TextField(placeholder, text: $text)
          .font(.title3)
          .frame(width: width - 24*2, height: 48, alignment: .center)
          .foregroundColor(.white)
      }
      .frame(width: width - 16*2, height: 48, alignment: .center)
      .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
      
      HStack {
        Spacer()
        Button(
          action: {
            text = ""
          },
          label: {
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
    TextFieldUpdated(
      text: .constant("Hello!"),
      placeholder: "Your new habit!",
      width: PreviewConstants.width
    )
    .padding()
    .previewLayout(.sizeThatFits)
  }
}
