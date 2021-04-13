//
//  Data-Extension.swift
//  DailyTasks
//
//  Created by Matthias Zarzecki on 13.04.21.
//

import Foundation

extension Data {
  func printJsonFromData() {
    print("JSON String: \(String(data: self, encoding: .utf8) ?? "")")
  }
}
