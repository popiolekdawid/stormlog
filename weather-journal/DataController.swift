//
//  DataController.swift
//  weather-journal
//
//  Created by Dawid Popiołek on 14/06/2023.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "WeatherJournal")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load \(error.localizedDescription)")
            }
        }
    }
}
