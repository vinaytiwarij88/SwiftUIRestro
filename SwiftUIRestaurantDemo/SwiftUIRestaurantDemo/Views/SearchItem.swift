//
//  SearchItem.swift
//  SwiftUIRestaurantDemo
//
//  Created by PCQ224 on 23/12/20.
//  Copyright © 2020 PCQ224. All rights reserved.
//

import SwiftUI

struct SearchItem: View {
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                
                // Search view
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("search", text: $searchText, onEditingChanged: { isEditing in
                            self.showCancelButton = true
                        }, onCommit: {
                            print("onCommit")
                        }).foregroundColor(.primary)
                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)
                    
                    if showCancelButton  {
                        Button("Cancel") {
                            UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                            self.searchText = ""
                            self.showCancelButton = false
                        }
                        .foregroundColor(Color(.systemBlue))
                    }
                }
                .padding(.horizontal)
                    .navigationBarHidden(showCancelButton) // .animation(.default) // animation does not work properly
                
                List {
                    ForEach(menu) { section in
                        ForEach(section.items.filter({$0.name.contains(self.searchText) || self.searchText == "" })) { item in
                            ItemRow.init(item: item)
                        }
                        
                    }
                }
            }
            .navigationBarTitle("Search")
            .listStyle(GroupedListStyle())
        }
    }
}

struct SearchItem_Previews: PreviewProvider {
    static var previews: some View {
        SearchItem()
    }
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}
