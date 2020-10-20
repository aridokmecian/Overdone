//
//  ListEntry.swift
//  overdone
//
//  Created by Ari Dokmecian on 2020-10-19.
//

import SwiftUI

struct ListEntry: View {
    
    @State var entry: TodoEntry
    
    var body: some View {
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
        .padding(.horizontal)
        .foregroundColor(.gray)
    }
}


struct ListEntry_Previews: PreviewProvider {
    static var previews: some View {
        ListEntry(entry: TodoEntry.init())
    }
}
