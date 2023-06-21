import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \JournalEntry.date, ascending: true)]) var entries: FetchedResults<JournalEntry>
    

    @State private var showingAddScreen = false
    @State private var showingEditScreen = false
    @State private var selectedEntry: JournalEntry?

    var body: some View {
        NavigationView {
            List {
                ForEach(entries) { entry in
                    NavigationLink(destination: DetailView(entry: entry)) {
                        HStack {
                            SingleRatingView(weather: entry.weather)
                                .font(.largeTitle)

                            VStack(alignment: .leading) {
                                Text(entry.city ?? "Unknown City")
                                    .font(.headline)
                                Text(String(entry.temperature))
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .contextMenu {
                        Button(action: {
                            // Handle edit action
                            selectedEntry = entry
                            showingEditScreen.toggle()
                        }) {
                            Label("Edit", systemImage: "pencil")
                        }

                        Button(action: {
                            // Handle delete action
                            moc.delete(entry)
                            try? moc.save()
                        }) {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                    .onLongPressGesture {
                        // Handle long press gesture
                        selectedEntry = entry
                        showingEditScreen.toggle()
                    }
                }
                .onDelete { indexSet in
                    let entriesToDelete = indexSet.map { entries[$0] }
                    entriesToDelete.forEach { entry in
                        moc.delete(entry)
                    }
                    try? moc.save()
                }
            }
            .navigationTitle("Weather Journal")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddScreen.toggle()
                    }) {
                        Label("Add Entry", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddEntryView()
            }
            .sheet(item: $selectedEntry) { entry in
                EditEntryView(entry: entry)
            }
        }
        .onAppear {
            // Load initial data or perform any necessary setup
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

