//
//  ProgressBar.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 17.04.21.
//

import SwiftUI

struct ProgressBar: View {
  var width: CGFloat
  var value: Double
  
  private let height: CGFloat = 10
  
  var body: some View {
    ZStack(alignment: .leading) {
      Rectangle()
        .frame(width: width, height: height)
        .opacity(0.3)
        .foregroundColor(.gray)
      
      Rectangle()
        .frame(
          width: min(CGFloat(self.value) * width, width),
          height: height
        )
        .foregroundColor(.green)
        .animation(.linear)
    }
    .cornerRadius(height / 2)
  }
}

struct ProgressBar_Previews: PreviewProvider {
  static var previews: some View {
    ProgressBar(
      width: PreviewConstants.width,
      value: 0.3
    )
    .previewLayout(.sizeThatFits)
  }
}
