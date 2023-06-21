//
//  AddEntryView.swift
//  weather-journal
//
//  Created by Dawid Popiołek on 14/06/2023.
//

import SwiftUI

struct AddEntryView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss

    @State private var city = ""
    @State private var comment = ""
    @State private var weather = 3
    @State private var temperature = 13

    let cities = ["Berlin", "Warsaw", "Barcelona", "Hong Kong", "Singapore", "New York", "Toronto", "Tokyo", "Osaka"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("General")) {
                    Picker("Choose a city", selection: $city) {
                        Text("").tag("")
                        ForEach(cities, id: \.self) { city in
                            Text(city)
                        }
                    }
                    Stepper("\(temperature) °C", value: $temperature, in: -50...50)
                }

                Section(header: Text("Weather Rating")) {
                    RatingView(weather: $weather)
                }

                Section(header: Text("Leave a Comment")) {
                    TextEditor(text: $comment)
                }

                Section {
                    Button("Save") {
                        saveEntry()
                    }
                }
            }
            .navigationTitle("New Entry")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func saveEntry() {
        guard !city.isEmpty else {
            // Show an error alert or handle empty city selection
            return
        }

        let newEntry = JournalEntry(context: moc)
        newEntry.id = UUID()
        newEntry.city = city
        newEntry.comment = comment
        newEntry.weather = Int16(weather)
        newEntry.temperature = Int16(temperature)
        newEntry.date = Date()
        //newEntry.weatherType = WeatherType()
        //let weatherEntry = JournalEntry(entity: WeatherType)
//        let newWeatherType = WeatherType(contex: moc)
//        newWeatherType.id = Int16(id)
//        newWeatherType.name = name

        do {
            try moc.save()
            dismiss()
        } catch {
            // Handle the error appropriately (e.g., show an error alert)
            print("Failed to save entry: \(error)")
        }
    }
}

struct AddEntryView_Previews: PreviewProvider {
    static var previews: some View {
        AddEntryView()
    }
}
