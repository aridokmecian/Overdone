//
//  ListEntry.swift
//  overdone
//
//  Created by Ari Dokmecian on 2020-10-19.
//

import SwiftUI

struct ListEntry: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State var entry: TodoEntry
    
    @State private var offset: CGFloat = 0 // 1
    @State private var disableButton = false
    @State private var isSwiped: Bool = false
    
    // Main view of function
    var body: some View {
        NavigationLink(
            destination: DrilldownView(entry: entry),
            label: {
                boxEntry
            })
            .buttonStyle(TapDisabledButtonStyle())
    }
    
    // View for a single boxEntry
    var boxEntry: some View {
        ZStack {
            if (offset != 0) {
                RoundedRectangle(cornerRadius: 9)
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            viewContext.delete(entry)
                            try? viewContext.save()
                        }
                    }) {
                    Image(systemName: "trash")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 90, height: 50)
                    }
                }
        
            }
            GroupBox(
                label: HStack {
                    Text(entry.text!).padding(.trailing, 4)
                    Spacer()
                    Image(systemName: "chevron.right").foregroundColor(Color(.systemGray4)).imageScale(.small)
                }
                    .foregroundColor(.blue)
            ) {
                HStack {
                    Text(entry.dueDate?.description ?? "No Due Date")
                    Spacer()
                }
            }
            .foregroundColor(.gray)
            .offset(x: offset)
            .disabled(disableButton || isSwiped)
            .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value:)))
        }
        .padding(.horizontal)
    }
    
    // func called when drag changes
    func onChanged(value: DragGesture.Value){
        
        if (value.translation.width < 0) {
            
            disableButton = true
            
            if (isSwiped) {
                offset = value.translation.width - 90
            }
            else {
                offset = value.translation.width
            }
        } else {
            disableButton = false
        }
    }

    // func called when drag stops changing
    func onEnded(value: DragGesture.Value){
           
           withAnimation(.easeOut){
               if (value.translation.width < 0) {
                disableButton = true
                   if (-value.translation.width > UIScreen.main.bounds.width / 2) {
                       offset = -1000
                   }
                   else if (-offset > 50) {
                       isSwiped = true
                       offset = -90
                   }
                   else {
                       isSwiped = false
                       offset = 0
                   }
               }
               else {
                    disableButton = false
                   isSwiped = false
                   offset = 0
               }
           }
       }
}

// Struct that hold buttonStyle that does not show animations
struct  TapDisabledButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
            configuration
            .label
            .foregroundColor(.blue)
    }
}


