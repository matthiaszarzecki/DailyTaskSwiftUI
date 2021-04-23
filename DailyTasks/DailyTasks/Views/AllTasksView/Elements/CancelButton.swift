//
//  CancelButton.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 23.04.21.
//

import SwiftUI

struct CancelButton: View {
  @Binding var showCreateTaskView: Bool
  
  var body: some View {
    Button(
      action: {
        withAnimation {
          showCreateTaskView = false
        }
      },
      label: {
        Text("Cancel")
          .padding()
          .backgroundColor(.red)
          .foregroundColor(.white)
          .cornerRadius(12)
          .shadow(radius: 10)
      }
    )
  }
}

struct CancelButton_Previews: PreviewProvider {
  static var previews: some View {
    CancelButton(showCreateTaskView: .constant(false))
      .padding()
      .previewLayout(.sizeThatFits)
  }
}
