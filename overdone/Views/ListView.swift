//
//  ListView.swift
//  overdone
//
//  Created by Ari Dokmecian on 2020-11-20.
//

import SwiftUI

struct ListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TodoEntry.dueDate, ascending: false)],
        animation: .default)
    
    private var entries: FetchedResults<TodoEntry>
    
    @State private var showNewTodoSheet = false
    @State private var showSettingsSheet = false
    
    @State private var showButton = true
    
    @State private var selection = 0
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Tasks")
                        .bold()
                        .font(.title)
                        .padding()
                    
                    Spacer()
                    
                    // Settings Button
                    Button(action: {
                        self.showSettingsSheet = true
                    }) {
                        Image(systemName: "gearshape.fill")
                            .labelsHidden()
                    }
                    .padding()
                    .font(.title)
                    .sheet(isPresented: $showSettingsSheet) {
                        SettingsView()
                    }
                    
                    // New Task Button
                    Button(action: {
                        self.showNewTodoSheet = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                    .padding()
                    .font(.title)
                    .sheet(isPresented: $showNewTodoSheet) {
                        NewTodoPage()
                    }
                }
                Spacer()
                Group {
                    if (entries.isEmpty) {
                        VStack(spacing: 16) {
                            Image("box")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100)
                            Text("You have no tasks today! Take it easy!")
                            Button(action: {
                                self.showNewTodoSheet = true
                            }, label: {
                                Text("Add a task!")
                            })
                        }
                    } else {
                        ScrollView {
                            Picker("Priority", selection: $selection) {
                                Text("None").tag(0)
                                    .font(.title)
                                Text("Low").tag(1)
                                    .font(.title)
                                Text("High").tag(2)
                                    .font(.title)
                            }.pickerStyle(SegmentedPickerStyle())
                            .padding()
                            LazyVStack(alignment: .center, pinnedViews: [.sectionFooters]) {
                                Section(footer: FloatingButtonView(action: {self.showNewTodoSheet = true}).padding()) {
                                    
                                    ForEach(entries) { entry in
                                        ListEntry(entry: entry)
                                    }
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
