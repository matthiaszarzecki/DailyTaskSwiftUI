//
//  SettingsView.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 17.04.21.
//

import SwiftUI

struct SettingsView: View {
  var width: CGFloat
  var deleteAllTasks: () -> Void
  var resetTasks: () -> Void
  var closeOverlay: () -> Void
  @Binding var userName: String
  
  @State private var showActualDeleteButton = false
  @State private var showActualResetButton = false
  
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
          .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
          .shadow(radius: 10)
      }
    )
  }
  
  var actualDeleteAllTasksButton: some View {
    Button(
      action: {
        deleteAllTasks()
        closeOverlay()
      },
      label: {
        Text("Confirm")
          .padding()
          .backgroundColor(.red)
          .foregroundColor(.white)
          .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
          .shadow(radius: 10)
      }
    )
  }
  
  var safeResetTasksButton: some View {
    Button(
      action: {
        withAnimation {
          showActualResetButton = true
        }
      },
      label: {
        Text("Reset All Tasks")
          .padding()
          .backgroundColor(.red)
          .foregroundColor(.white)
          .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
          .shadow(radius: 10)
      }
    )
  }
  
  var actualResetTasksButton: some View {
    Button(
      action: {
        resetTasks()
        closeOverlay()
      },
      label: {
        Text("Confirm")
          .padding()
          .backgroundColor(.red)
          .foregroundColor(.white)
          .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
          .shadow(radius: 10)
      }
    )
  }
  
  var debugActions: some View {
    VStack {
      Text("Debug Actions")
        .font(.title)
      
      HStack {
        safeDeleteAllTasksButton
        if showActualDeleteButton {
          actualDeleteAllTasksButton
        }
      }
      HStack {
        safeResetTasksButton
        if showActualResetButton {
          actualResetTasksButton
        }
      }
    }
    .frame(width: width - 32*2, height: 150, alignment: .center)
    .padding()
    .backgroundColor(.dailyHabitsGray)
    .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
  }
  
  var profileNameAndImage: some View {
    HStack {
      TextFieldUpdated(
        text: $userName,
        placeholder: "What's your name?",
        width: width - 80
      )

      Spacer()
      
      Image(systemName: "person.crop.circle")
        .foregroundColor(.dailyHabitsGreen)
        .font(.title)
        .padding()
    }
    .padding()
  }
  
  var body: some View {
    ZStack {
      // Empty background
      Rectangle()
        .foregroundColor(.clear)
      
      VStack {
        // Upper "empty" part
        Spacer()
        
        // The actual view
        VStack {
          profileNameAndImage
          debugActions
          CancelButton(
            closeOverlay: { closeOverlay() },
            color: .dailyHabitsGreen
          )
        }
        .frame(width: width - 12, height: UIScreen.main.bounds.size.height * 0.5, alignment: .center)
        .backgroundColor(.white)
        .cornerRadius(8, corners: [.topLeft, .topRight])
        .cornerRadius(38, corners: [.bottomLeft, .bottomRight])
        .shadow(color: .black, radius: 6)
        .overlay(
          HandleForOverlay(closeOverlay: closeOverlay),
          alignment: .top
        )
      }
      // Move everything up a bit for
      // the line between the view at
      // the bottom of the screen.
      .offset(y: -4)
      .edgesIgnoringSafeArea(.all)
    }
    .transition(AnyTransition.opacity.combined(with: .move(edge: .bottom)))
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Rectangle()
        .edgesIgnoringSafeArea(.all)
        .foregroundColor(.green)
      
      SettingsView(
        width: PreviewConstants.width,
        deleteAllTasks: {},
        resetTasks: {},
        closeOverlay: {},
        userName: .constant(MockClasses.userName)
      )
    }
  }
}
