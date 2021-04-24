//
//  HandleForOverlay.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 24.04.21.
//

import SwiftUI

struct HandleForOverlay: View {
  @Binding var showParentView: Bool
  
  var body: some View {
    Button(
      action: {
        withAnimation {
          showParentView = false
        }
      },
      label: {
        Rectangle()
          .frame(width: 60, height: 6, alignment: .center)
          .mask(RoundedRectangle(cornerRadius: 3, style: .continuous))
          .foregroundColor(.dailyHabitsGray)
          .padding(EdgeInsets(top: 8, leading: 12, bottom: 12, trailing: 12))
      }
    )
  }
}

struct HandleForOverlay_Previews: PreviewProvider {
  static var previews: some View {
    HandleForOverlay(showParentView: .constant(false))
      .padding()
      .previewLayout(.sizeThatFits)
  }
}
