//
//  ItemDetail.swift
//  SwiftUIRestaurantDemo
//
//  Created by PCQ224 on 22/12/20.
//  Copyright © 2020 PCQ224. All rights reserved.
//

import SwiftUI
struct ItemDetail: View {
    
    var item: MenuItem
    @EnvironmentObject var order: Order
    @State private var showingAlert = false
    
    
    func btnOrderClicked() {
        if self.order.items.contains(self.item) {
            self.showingAlert = true
        } else {
            self.order.add(item: self.item)
            DispatchQueue.main.asyncAfter(deadline: .now() , execute: {
                withAnimation(.default){
                    self.order.objectWillChange.send()
                }
            })
        }
    }
    
    var body: some View {
        VStack {
            
            ZStack(alignment: .bottomTrailing) {
                Image(item.mainImage)
                Text("Photo: \(item.photoCredit)")
                    .padding(4)
                    .background(Color.black)
                    .font(.caption)
                    .foregroundColor(.white)
                    .offset(x: -5, y: -5)
                    .padding(4)
                    .background(Color.black)
                    .font(.caption)
                    .foregroundColor(.white)
            }
            Text(item.description)
                .padding()
            
            Button(action: {self.btnOrderClicked()}) {
                VStack(alignment: .center, spacing: 20)  {
                    Text(order.items.contains(self.item) ? "REMOVE" :"ADD")
                        .frame(minWidth: 65, maxWidth: UIScreen.main.bounds.width - 40)
                        .padding(.all, 12)
                        .foregroundColor(.white)
                        .background( order.items.contains(self.item) ? Color.red :Color.green)
                        .font(.headline)
                }
            }
            
            Spacer()
        }
        .navigationBarTitle(Text(item.name), displayMode: .inline)
        .alert(isPresented:$showingAlert) {
            Alert(title: Text("Are you sure you want to remove this?"), message: Text(""), primaryButton: .destructive(Text("Remove")) {
                self.order.remove(item: self.item)
                self.order.objectWillChange.send()
                }, secondaryButton: .cancel())
        }
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static let order = Order()
    static var previews: some View {
        NavigationView {
            ItemDetail(item: MenuItem.example).environmentObject(order)
        }
    }
}
