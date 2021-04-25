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
          .backgroundColor(.dailyHabitsGreen)
          .foregroundColor(.white)
          .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
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
          .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
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
          .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
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
      resetTasksButton
    }
    .frame(width: width - 32*2, height: 150, alignment: .center)
    .padding()
    .backgroundColor(.dailyHabitsGray)
    .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
  }
  
  var profileNameAndImage: some View {
    HStack {
      Text("What's your name?")
        .font(.title)
      
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
      OverlayBackground(showParentView: $showSettingsView)
      
      VStack {
        // Upper "empty" part
        Spacer()
        
        // The actual view
        VStack {
          profileNameAndImage
          debugActions
          GoBackButton
        }
        .frame(width: width - 8, height: UIScreen.main.bounds.size.height * 0.5, alignment: .center)
        .backgroundColor(.white)
        .cornerRadius(8, corners: [.topLeft, .topRight])
        .cornerRadius(46, corners: [.bottomLeft, .bottomRight])
        .shadow(color: .black, radius: 6)
        .overlay(
          HandleForOverlay(showParentView: $showSettingsView),
          alignment: .top
        )
      }
      // Move everything up a bit for
      // the line between the view at
      // the bottom of the screen.
      .offset(y: -4)
      .edgesIgnoringSafeArea(.all)
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Rectangle()
        .edgesIgnoringSafeArea(.all)
        .foregroundColor(.green)
      
      SettingsView(
        showSettingsView: .constant(false),
        width: PreviewConstants.width,
        deleteAllTasks: {},
        resetTasks: {}
      )
    }
  }
}