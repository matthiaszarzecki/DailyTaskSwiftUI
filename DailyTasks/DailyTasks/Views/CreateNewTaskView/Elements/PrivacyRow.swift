//
//  PrivacyRow.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 25.08.22.
//

import SwiftUI

struct PrivacyRow: View {
  @Binding var isPrivate: Bool

  private let padding: CGFloat = .spacing6

  private let privacyOptions: [(isPrivate: Bool, title: String)] = [
    (false, "Public"),
    (true, "Private")
  ]

  var body: some View {
    HStack {
      ForEach(privacyOptions, id: \.title) { privacyOption in
        if isPrivate == privacyOption.isPrivate {
          Text(privacyOption.title)
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
              isPrivate.toggle()
            },
            label: {
              Text(privacyOption.title)
                .padding(padding)
                .backgroundColor(.gray)
                .foregroundColor(.white)
                .mask(
                  RoundedRectangle(
                    cornerRadius: 10,
                    style: .continuous
                  )
                )
            }
          )
        }
      }
    }
    .padding(.spacing6)
  }
}

struct PrivacyRow_Previews: PreviewProvider {
  static var previews: some View {
    PrivacyRow(
      isPrivate: .constant(false)
    )
    .padding()
    .previewLayout(.sizeThatFits)
  }
}
