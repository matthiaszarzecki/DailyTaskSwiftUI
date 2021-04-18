//
//  File.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 18.04.21.
//

import Foundation
import SwiftUI

struct RoundedCorner: Shape {
  var radius: CGFloat = .infinity
  var corners: UIRectCorner = .allCorners
  
  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(
      roundedRect: rect,
      byRoundingCorners: corners,
      cornerRadii: CGSize(width: radius, height: radius)
    )
    return Path(path.cgPath)
  }
}

struct RoundedCorner_Previews: PreviewProvider {
  static var previews: some View {
    Rectangle()
      .foregroundColor(.red)
      .cornerRadius(44, corners: [.topLeft, .bottomRight])
      .frame(width: 100, height: 100, alignment: .center)
      .padding()
      .previewLayout(.sizeThatFits)
  }
}
