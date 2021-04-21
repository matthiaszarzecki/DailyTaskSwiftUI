//
//  IconGrid.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 21.04.21.
//

import SwiftUI

struct IconGrid: View {
  var body: some View {
    let padding: CGFloat = 10
    let cellWidthSmall: CGFloat = 33
    let column = GridItem(.fixed(cellWidthSmall), spacing: padding, alignment: .leading)
    let gridItems = [column, column, column, column]
    
    LazyVGrid(columns: gridItems, spacing: padding) {
      ForEach(0..<10) { index in
        Text("\(index)")
          .frame(width: cellWidthSmall, height: cellWidthSmall)
          .background(Color.red)
          .cornerRadius(24)
          .shadow(radius: 6)
      }
    }
    .frame(width: 330)
  }
}

struct IconGrid_Previews: PreviewProvider {
  static var previews: some View {
    IconGrid()
  }
}
