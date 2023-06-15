//
//  weather_journalApp.swift
//  weather-journal
//
//  Created by Dawid Popiołek on 14/06/2023.
//

import SwiftUI

@main
struct weather_journalApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
