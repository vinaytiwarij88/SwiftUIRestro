//
//  AppView.swift
//  SwiftUIRestaurantDemo
//
//  Created by PCQ224 on 22/12/20.
//  Copyright © 2020 PCQ224. All rights reserved.
//

import SwiftUI

struct AppView: View {
    var body: some View{
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Menu")
            }
            SearchItem()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
            }
            OrderView()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("Cart")
            }
            UserProfile()
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("Account")
            }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static let order = Order()
    static var previews: some View {
        AppView().environmentObject(order)
    }
}
