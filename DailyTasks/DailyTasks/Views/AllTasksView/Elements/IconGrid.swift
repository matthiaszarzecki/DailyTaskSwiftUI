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
  
  private let iconOptions = [
    "drop",
    "applewatch",
    "pencil",
    "folder",
    "eye"/*,
    "message",
    "guitars",
    "chevron.left.slash.chevron.right",
    "hare",
    "snow",
    "figure.walk"*/
  ]
  private let iconSize: CGFloat = 40
  private let padding: CGFloat = 10
  private let cellWidthSmall: CGFloat = 33

  var body: some View {
    let column = GridItem(.fixed(cellWidthSmall), spacing: padding, alignment: .leading)
    let gridItems = [column, column, column, column, column, column, column]
    
    return LazyVGrid(columns: gridItems, spacing: padding) {
      ForEach(iconOptions, id: \.self) { option in
        if selectedIcon == option {
          Image(systemName: option)
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
              selectedIcon = option
            },
            label: {
              Image(systemName: option)
                .frame(width: iconSize, height: iconSize, alignment: .center)
                .backgroundColor(.gray)
                .foregroundColor(.white)
                .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }
          )
        }
      }
    }
    .padding()
    .frame(width: width - 16*2)
  }
}

struct IconGrid_Previews: PreviewProvider {
  static var previews: some View {
    IconGrid(
      selectedIcon: .constant("folder"),
      width: PreviewConstants.width
    )
    .previewLayout(.sizeThatFits)
  }
}
