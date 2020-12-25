//
//  OrderView.swift
//  SwiftUIRestaurantDemo
//
//  Created by PCQ224 on 22/12/20.
//  Copyright © 2020 PCQ224. All rights reserved.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject var order: Order
    
    func delete(at offsets: IndexSet) {
        offsets.forEach { (i) in
            self.order.items.remove(at: i)
            self.order.objectWillChange.send()
        }
    }
    
    var body: some View {
        NavigationView {
            
            List {
                Section {
                    ForEach(order.items) { item in
                        HStack {
                            NavigationLink(destination: ItemDetail.init(item: item)) {
                                
                                Text(item.name)
                                Spacer()
                                Text("$\(item.price)")
                            }
                        }
                    }
                    .onDelete(perform: delete)
                    .animation(.spring())
                    .transition(.move(edge: .leading))
                    
                    
                }
                if order.items.count > 0 {
                    Section {
                        NavigationLink(destination: CheckoutView()) {
                            VStack(alignment: .center, spacing: 20)  {
                                Text("PLACE ORDER")
                                    .frame(minWidth: 65, maxWidth: UIScreen.main.bounds.width - 40)
                                    .padding(.all, 12)
                                    .foregroundColor(.white)
                                    .background(Color.red)
                                    .font(.headline)
                            }
                            //.frame(maxWidth: .infinity)
                        }
                    }
                } else {
                    Text("No orders found!")
                        .frame(maxWidth: .infinity)
                        .animation(.linear)
                        .transition(.move(edge: .bottom))
                }
            }
            .navigationBarTitle("Order")
            .listStyle(GroupedListStyle())
            
                
        }.onAppear(perform: {
            print("Latest orders count : \(self.order.items.count)")
        })
        
    }
}

struct OrderView_Previews: PreviewProvider {
    static let order = Order()
    
    static var previews: some View {
        OrderView().environmentObject(order)
    }
}
