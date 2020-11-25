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
                        
                            Button(action: {
                                self.showNewTodoSheet = true
                            }, label: {
                                VStack(spacing: -30) {
                                    
                                    ZStack {
                                        RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                                            .fill()
                                            .frame(width: 320, height: 300, alignment: .center)
                                            .padding(.all, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                                .shadow(radius: 10)
                                        VStack {
                                            Text("Add a task!")
                                                .font(.title)
                                                .foregroundColor(.white)
                                                .bold()
                                            Image("box")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                        }
                                        .frame(width: 300, height: 300, alignment: .center)
                                    }
                                }
                            })
                        
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
                                Section(footer: FloatingButtonView(action: {self.showNewTodoSheet = true})) {
                                    
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
        Group {
            ListView()
        }
            
    }
}
