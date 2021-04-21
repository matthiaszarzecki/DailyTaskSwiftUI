//
//  SettingsView.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 17.04.21.
//

import SwiftUI

struct SettingsView: View {
  @Binding var showSettingsView: Bool
  var width: CGFloat
  var deleteAllTasks: () -> Void
  var resetTasks: () -> Void
  
  @State private var showActualDeleteButton = false

  var cancelButton: some View {
    Button(
      action: {
        withAnimation {
          showSettingsView = false
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
  
  var GoBackButton: some View {
    Button(
      action: {
        withAnimation {
          showSettingsView = false
        }
      },
      label: {
        Text("Go Back")
          .padding()
          .backgroundColor(.green)
          .foregroundColor(.white)
          .cornerRadius(12)
          .shadow(radius: 10)
      }
    )
  }
  
  var safeDeleteAllTasksButton: some View {
    Button(
      action: {
        withAnimation {
          showActualDeleteButton = true
        }
      },
      label: {
        Text("Delete All Tasks")
          .padding()
          .backgroundColor(.red)
          .foregroundColor(.white)
          .cornerRadius(12)
          .shadow(radius: 10)
      }
    )
  }
  
  var actualDeleteAllTasksButton: some View {
    Button(
      action: {
        deleteAllTasks()
        withAnimation {
          showSettingsView = false
        }
      },
      label: {
        Text("Confirm")
          .padding()
          .backgroundColor(.red)
          .foregroundColor(.white)
          .cornerRadius(12)
          .shadow(radius: 10)
      }
    )
  }
  
  var resetTasksButton: some View {
    Button(
      action: {
        resetTasks()
        withAnimation {
          showSettingsView = false
        }
      },
      label: {
        Text("Reset All Tasks")
          .padding()
          .backgroundColor(.blue)
          .foregroundColor(.white)
          .cornerRadius(12)
          .shadow(radius: 10)
      }
    )
  }

  var body: some View {
    ZStack {
      Rectangle()
        .foregroundColor(.clear)
      
      VStack {
        Spacer()
        Text("Actions")
          .font(.largeTitle)
        HStack {
          safeDeleteAllTasksButton
          if showActualDeleteButton {
            actualDeleteAllTasksButton
          }
        }
        
        resetTasksButton
        Spacer()
        GoBackButton
        Spacer()
      }
      .frame(width: width - 32*2, height: 400, alignment: .center)
      .padding()
      .backgroundColor(.white)
      .cornerRadius(12)
      .shadow(radius: 10)
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    GeometryReader { geometry in
      SettingsView(
        showSettingsView: .constant(false),
        width: geometry.size.width,
        deleteAllTasks: {},
        resetTasks: {}
      )
      .previewLayout(.sizeThatFits)
      .backgroundColor(.green)
    }
  }
}
