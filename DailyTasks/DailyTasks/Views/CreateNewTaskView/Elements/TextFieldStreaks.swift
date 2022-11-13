//
//  TextFieldStreaks.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 13.11.22.
//

import SwiftUI

struct TextFieldStreaks: View {
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
          .frame(width: width - .spacing24 * 2, height: 48, alignment: .center)
          .foregroundColor(.white)
      }
      .frame(width: width - .spacing16 * 2, height: 48, alignment: .center)
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
              .padding(
                EdgeInsets(
                  top: .spacing16,
                  leading: .spacing16,
                  bottom: .spacing16,
                  trailing: .spacing8
                )
              )
          }
        )
      }
    }
    .padding()
    .frame(width: width - .spacing16 * 2, height: 48, alignment: .center)
  }
}

struct TextFieldStreaks_Previews: PreviewProvider {
  static var previews: some View {
    TextFieldUpdated(
      text: .constant("123"),
      placeholder: "123",
      width: .previewWidth
    )
    .padding()
    .previewLayout(.sizeThatFits)
  }
}
