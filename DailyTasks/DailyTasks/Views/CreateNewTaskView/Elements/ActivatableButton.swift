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
      Button(
        action: actionWhenActive,
        label: {
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
      )
    } else {
      Button(
        action: actionWhenInActive,
        label: {
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
      )
    }
  }
}

