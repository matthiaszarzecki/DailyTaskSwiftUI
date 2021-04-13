//
//  ContentView.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 13.04.21.
//

import SwiftUI

struct ContentView: View {
  @AppStorage("tasks")
  private var tasksData: Data = Data()
  
  @State private var outputTasks = [Task]()
  
  var body: some View {
    VStack {
      Button("Load from Storage") {
        guard let tasks = try? JSONDecoder().decode([Task].self, from: tasksData) else {
          return
        }
        outputTasks = tasks
      }
      
      Button("New Task") {
        let task = Task(
          name: "Drink Water \(Int.random(in: 0...100))",
          status: false
        )
        outputTasks.append(task)
        
        guard let tasksData = try? JSONEncoder().encode(outputTasks) else {
          return
        }
        self.tasksData = tasksData
      }
      
      ForEach(outputTasks, id: \.self) { task in
        Text("\(task.name)")
      }
      
      /*Button("Save to storage") {
        let task = Task(name: "Drink Water", status: false)
        
        guard let taskData = try? JSONEncoder().encode(task) else {
          return
        }
        
        self.taskData = taskData
      }*/
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
