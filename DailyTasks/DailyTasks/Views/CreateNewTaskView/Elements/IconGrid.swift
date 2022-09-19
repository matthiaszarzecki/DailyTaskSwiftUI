//
//  IconGrid.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 21.04.21.
//

import SwiftUI

struct IconGrid: View {
  @Binding var selectedIcon: String
  var width: CGFloat

  private let iconSize: CGFloat = 36
  private let padding: CGFloat = 10
  private let cellWidthSmall: CGFloat = 33

  var body: some View {
    let column = GridItem(
      .fixed(cellWidthSmall),
      spacing: padding,
      alignment: .leading
    )
    let gridItems = [column, column, column, column, column, column, column]

    return LazyVGrid(columns: gridItems, spacing: padding) {
      ForEach(TaskIcon.allCases, id: \.rawValue) { icon in
        let iconName = icon.rawValue

        if selectedIcon == iconName {
          Image(systemName: iconName)
            .frame(width: iconSize, height: iconSize, alignment: .center)
            .backgroundColor(.white)
            .foregroundColor(.gray)
            .overlay(
              RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 2)
            )
        } else {
          Button(
            action: {
              selectedIcon = iconName
            },
            label: {
              Image(systemName: iconName)
                .frame(
                  width: iconSize,
                  height: iconSize,
                  alignment: .center
                )
                .backgroundColor(.gray)
                .foregroundColor(.white)
                .mask(
                  RoundedRectangle(
                    cornerRadius: 10, style: .continuous
                  )
                )
            }
          )
        }
      }
    }
    .padding()
    .frame(width: width - .spacing16 * 2)
  }
}

struct IconGrid_Previews: PreviewProvider {
  static var previews: some View {
    IconGrid(
      selectedIcon: .constant(TaskIcon.bicycle.rawValue),
      width: .previewWidth
    )
    .padding()
    .previewLayout(.sizeThatFits)
  }
}
