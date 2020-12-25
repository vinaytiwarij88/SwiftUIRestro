//
//  AddressView.swift
//  SwiftUIRestaurantDemo
//
//  Created by PCQ224 on 24/12/20.
//  Copyright © 2020 PCQ224. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    let myAddress = Bundle.main.decode(AddressSection.self, from: "location.json")
    var body: some View {
        VStack {
            List {
                ForEach(myAddress.items, id: \.self) { section in
                    NavigationLink(destination: AddAddressView(isAdd: false, addressObj: section)) {
                        Text(section.title)
                    }
                }
            }
        }
        .navigationBarTitle("Address")
        .listStyle(GroupedListStyle())
        .navigationBarItems(trailing:
            
            NavigationLink(destination: AddAddressView(isAdd: true)) {
                VStack(alignment: .center, spacing: 20)  {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25)
                        .accentColor(.red)
                }
            }
        )
        
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView()
    }
}
