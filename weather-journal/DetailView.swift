//
//  DetailView.swift
//  weather-journal
//
//  Created by Dawid Popiołek on 15/06/2023.
//

import SwiftUI
import CoreData

struct DetailView: View {
    let entry: JournalEntry
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            ZStackLayout(alignment: .bottomTrailing) {
                Image(entry.city ?? "Others")
                    .resizable()
                    .scaledToFit()

                Text(entry.city?.uppercased() ?? "Others")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .offset(x: -5, y: -5)
            }
            
            Text("Temperature was \(String(entry.temperature))°C")
                .font(.title3.italic())
                .foregroundColor(.secondary)
                .padding()
            
            Text("Comment:")
                .font(.headline)
            
            Text(entry.comment ?? "No comments")
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
                )
            SingleRatingView(weather: entry.weather)
                .font(.largeTitle)
                        
            VStack {
                Text("Registered on")
                Text(entry.date ?? Date.now, format: .dateTime.minute().hour().day().month().year())
            }
            .font(.caption)
            .foregroundColor(.secondary)
            .padding(.vertical)
        }
        .navigationTitle(entry.city ?? "Unknown entry")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete entry?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteEntry)
            Button("Cancel", role: .cancel) {  }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: EditEntryView(entry: entry)) {
                    Label("Edit", systemImage: "pencil")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingDeleteAlert = true
                }) {
                    Label("Delete", systemImage: "trash")
                }
            }
    }
}
    
    func deleteEntry() {
        moc.delete(entry)
        
        try? moc.save()
        
        dismiss()
    }
}
