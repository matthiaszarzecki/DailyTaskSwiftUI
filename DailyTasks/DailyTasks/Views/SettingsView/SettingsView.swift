//
//  SettingsView.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 17.04.21.
//

import SwiftUI

struct SettingsView: View {
  let width: CGFloat
  let deleteAllTasks: () -> Void
  let resetTasks: () -> Void
  let closeOverlay: () -> Void
  @Binding var userName: String
  @Binding var isPrivacyEnabled: Bool

  @State private var showActualDeleteButton = false
  @State private var showActualResetButton = false

  private var safeDeleteAllTasksButton: some View {
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

  private var actualDeleteAllTasksButton: some View {
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

  private var safeResetTasksButton: some View {
    Button(
      action: {
        withAnimation {
          showActualResetButton = true
        }
      },
      label: {
        Text("Jump to next day")
          .padding()
          .backgroundColor(.red)
          .foregroundColor(.white)
          .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
          .shadow(radius: 10)
      }
    )
  }

  private var actualResetTasksButton: some View {
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

  private var debugActions: some View {
    VStack {
      Text("Debug Actions")
        .font(.title2)

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
    .frame(width: width - .spacing32 * 2, height: 150, alignment: .center)
    .padding()
    .backgroundColor(.dailyHabitsGray)
    .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
  }

  private var profileNameAndImage: some View {
    HStack {
      TextFieldUpdated(
        text: $userName,
        placeholder: "What's your name?",
        width: width * 0.8
      )

      Image(systemName: "person.crop.circle")
        .foregroundColor(.dailyHabitsGreen)
        .font(.system(size: 42))
        .padding(.leading, .spacing4)
        .padding(4)
    }
    .frame(width: width - 12, alignment: .center)
    .padding(.bottom, .spacing8)
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

          Toggle(
            "Private Mode",
            isOn: $isPrivacyEnabled
          )
          .tint(.dailyHabitsGreen)
          .frame(width: width - .spacing16 * 2, alignment: .center)
          .padding(.bottom, .spacing12)

          debugActions

          CancelButton(
            closeOverlay: closeOverlay,
            color: .dailyHabitsGreen
          )
        }
        .frame(
          width: width - .spacing6 * 2,
          height: UIScreen.main.bounds.size.height * 0.5,
          alignment: .center
        )
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
      .offset(y: -.spacing4)
      .edgesIgnoringSafeArea(.all)
    }
    .transition(
      AnyTransition.opacity.combined(with: .move(edge: .bottom))
    )
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Rectangle()
        .edgesIgnoringSafeArea(.all)
        .foregroundColor(.green)

      SettingsView(
        width: .previewWidth,
        deleteAllTasks: {},
        resetTasks: {},
        closeOverlay: {},
        userName: .constant(.mockUserName),
        isPrivacyEnabled: .constant(true)
      )
    }
  }
}
