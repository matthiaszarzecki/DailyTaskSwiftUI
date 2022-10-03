//
//  ActivatableButton.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 03.10.22.
//

import SwiftUI

struct ActivatableButton: View {
  let displayName: String
  let isActive: Bool
  let actionWhenActive: () -> Void
  let actionWhenInActive: () -> Void
  let padding: CGFloat
  let width: CGFloat

  var body: some View {
    if isActive {
      Button(action: actionWhenActive) {
        Text(displayName)
          .padding(padding)
          .frame(width: width)
          .backgroundColor(.white)
          .foregroundColor(.gray)
          .overlay(
            RoundedRectangle(cornerRadius: 10)
              .stroke(Color.gray, lineWidth: 2)
          )
      }
    } else {
      Button(action: actionWhenInActive) {
        Text(displayName)
          .padding(padding)
          .frame(width: width)
          .backgroundColor(.gray)
          .foregroundColor(.white)
          .mask(
            RoundedRectangle(
              cornerRadius: 10,
              style: .continuous
            )
          )
      }
    }
  }
}

struct ActivatableButton_Previews: PreviewProvider {
  static var previews: some View {
    let configurations = [true, false]

    ForEach(configurations, id: \.self) { configuration in
      ActivatableButton(
        displayName: "Hello",
        isActive: configuration,
        actionWhenActive: {},
        actionWhenInActive: {},
        padding: .spacing4,
        width: 38
      )
      .padding()
      .previewLayout(.sizeThatFits)
    }
  }
}
