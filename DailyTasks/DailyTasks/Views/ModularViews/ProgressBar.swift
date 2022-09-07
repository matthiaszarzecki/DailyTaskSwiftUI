//
//  ProgressBar.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 17.04.21.
//

import SwiftUI

struct ProgressBar: View {
  let width: CGFloat
  let value: Double

  private let height: CGFloat = 14

  private var background: some View {
    Rectangle()
      .frame(width: width, height: height)
      .opacity(0.3)
      .foregroundColor(.gray)
  }

  private var greenProgressPart: some View {
    ZStack {
      let accomplishedPartWidth = min(CGFloat(self.value) * width, width)

      Rectangle()
        .frame(
          width: accomplishedPartWidth,
          height: height
        )
        .foregroundColor(.dailyHabitsGreen)
        .mask(RoundedRectangle(cornerRadius: height / 2, style: .continuous))
        .animation(.easeOut(duration: 0.75), value: value)

      // Highlight
      let sidePadding: CGFloat = .spacing6
      Rectangle()
        .frame(
          width: (0.0...accomplishedPartWidth).clamp(
            accomplishedPartWidth - sidePadding
          ),
          height: height * 0.35
        )
        .foregroundColor(.dailyHabitsGreenHighlight)
        .mask(RoundedRectangle(cornerRadius: height / 2, style: .continuous))
        .animation(.easeOut(duration: 0.75), value: value)
        .offset(y: -1)
    }
  }

  var body: some View {
    ZStack(alignment: .leading) {
      background
      greenProgressPart
    }
    .mask(RoundedRectangle(cornerRadius: height / 2, style: .continuous))
  }
}

extension ClosedRange {
  /// Fits an input value to the specified range.
  /// - Example:
  /// (0.0...1.0).clamp(accomplishedPartWidth - sidePadding)
  func clamp(_ value: Bound) -> Bound {
    self.lowerBound > value
      ? self.lowerBound
      : self.upperBound < value
      ? self.upperBound
      : value
  }
}

struct ProgressBar_Previews: PreviewProvider {
  static var previews: some View {
    let configurations: [CGFloat] = [0, 0.1, 0.3, 0.9, 1]

    ForEach(0..<configurations.count, id: \.self) { index in
      let configuration = configurations[index]

      ProgressBar(
        width: .previewWidth,
        value: configuration
      )
      .padding()
      .previewLayout(.sizeThatFits)
    }
  }
}
