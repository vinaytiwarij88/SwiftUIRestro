//
//  AddAddressView.swift
//  SwiftUIRestaurantDemo
//
//  Created by PCQ224 on 24/12/20.
//  Copyright © 2020 PCQ224. All rights reserved.
//

import SwiftUI

struct AddAddressView: View {
    
    @State var title = ""
    @State var category = 0
    @State var address = ""
    @State var pinCode = ""
    static let categories = ["Home", "Office"]
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false
    var isAdd = true
    var addressObj: Addresses?
    
    func formValidation()-> Bool  {
        return (title.isEmpty || pinCode.isEmpty || address.isEmpty)
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Enter address title", text: $title)
                TextField("Enter address", text: $address)
                TextField("Enter PIN Code", text: $pinCode).keyboardType(.numberPad)
                
            }.padding(20)
            
            Section(header: Text("Select Category")) {
                Picker("Percentage:", selection: $category) {
                    ForEach(0 ..< Self.categories.count) {
                        Text("\(Self.categories[$0])")
                    }
                }.pickerStyle(SegmentedPickerStyle())
                    .colorMultiply(.red)
            }.padding(20)
        }
        .navigationBarItems(trailing:
            Button(action: {
                self.showingAlert.toggle()
            }) {
                VStack(alignment: .center, spacing: 10)  {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25)
                        .accentColor(.red)
                }
            }
        .disabled(formValidation())
        )
            .alert(isPresented:$showingAlert) {
                Alert(title: Text("Address has been added."), message: Text(""), dismissButton: .default(Text("OK")) {
                    self.presentationMode.wrappedValue.dismiss()
                    })
        }
        .onAppear {
            if self.isAdd == false {
                self.title = self.addressObj?.title ?? ""
                self.category = self.addressObj?.category == "Home" ? 0 : 1
                self.address = self.addressObj?.address ?? ""
                self.pinCode = self.addressObj?.pinCode ?? ""
            }
        }
    }
    
    
}

struct AddAddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddAddressView()
    }
}
