//
//  EditEntryView.swift
//  weather-journal
//
//  Created by Dawid Popiołek on 15/06/2023.
//

import SwiftUI
import CoreData

struct EditEntryView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss

    var entry: JournalEntry

    @State private var city: String
    @State private var comment: String
    @State private var weather: Int
    @State private var temperature: Int

    let cities = ["Berlin", "Warsaw", "Barcelona", "Hong Kong", "Singapore", "New York", "Toronto", "Tokyo", "Osaka"]

    init(entry: JournalEntry) {
        self.entry = entry

        _city = State(initialValue: entry.city ?? "")
        _comment = State(initialValue: entry.comment ?? "")
        _weather = State(initialValue: Int(entry.weather))
        _temperature = State(initialValue: Int(entry.temperature))
    }

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
            .navigationTitle("Edit Entry")
            .onAppear {
                city = entry.city ?? ""
                comment = entry.comment ?? ""
                weather = Int(entry.weather)
                temperature = Int(entry.temperature)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        } .navigationBarBackButtonHidden(true)
    }

    private func saveEntry() {
        guard !city.isEmpty else {
            // Show an error alert or handle empty city selection
            return
        }

        entry.city = city
        entry.comment = comment
        entry.weather = Int16(weather)
        entry.temperature = Int16(temperature)

        do {
            try moc.save()
            dismiss()
        } catch {
            // Handle the error appropriately (e.g., show an error alert)
            print("Failed to save entry: \(error)")
        }
    }
}


//struct EditEntryView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditEntryView()
//    }
//}
