//
//  UpdateProfile.swift
//  SwiftUIRestaurantDemo
//
//  Created by PCQ224 on 23/12/20.
//  Copyright © 2020 PCQ224. All rights reserved.
//

import SwiftUI

struct UpdateProfile: View {
    
    @State var choice = Choice.email
    @State var email: String = ""
    @State var phoneNumber: String = ""
    @State var name: [String] = []
    @State var oldPassword: String = ""
    @State var newPassword: String = ""
    @State var confirmPassword: String = ""
    @State private var showingAlert = false
    @Environment(\.presentationMode) var presentationMode

    
    enum Choice: Equatable {
        case email
        case password
        case phone
    }
    
    func formValidation()-> Bool  {
        if choice == .email {
            return email.isEmpty
        }else if choice == .password {
            return (oldPassword.isEmpty || confirmPassword.isEmpty || newPassword.isEmpty)
        }else{
            return phoneNumber.isEmpty
        }
    }
    
    func btnUpdateClicked() {
        self.showingAlert = true
    }
    
    
    func getNavName() -> String {
        var strNavTitle = ""
        if choice == .email {
            strNavTitle = "Update Email"
        }else if choice == .password {
            strNavTitle = "Update Password"
        }else if choice == .phone {
            strNavTitle = "Update Phone"
        }
        return strNavTitle
    }
    
    func setView() -> some View  {
        if choice == .email {
            return AnyView(VStack {
                TextField("Email", text: $email)
                    .padding(20)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            })
        }else if choice == .password {
            return AnyView(VStack {
                SecureField("Old Password", text: $oldPassword)
                    .padding(20)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("New Password", text: $newPassword)
                    .padding(20)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Confirm Password", text: $confirmPassword)
                    .padding(20)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            })
        }else {
            return AnyView(VStack {
                TextField("Phone", text: $phoneNumber)
                    .padding(20)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            })
        }
    }
    
    var body: some View {
        VStack {
            setView()
            HStack {
                Button(action: {self.btnUpdateClicked()}) {
                    VStack(alignment: .center, spacing: 10)  {
                        Text("UPDATE")
                            .frame(minWidth: 45, maxWidth: UIScreen.main.bounds.width - 60)
                            .padding(.all, 12)
                            .foregroundColor(.white)
                           // .background(Color.red)
                            .background(formValidation() ? Color.gray : Color.red)

                            .font(.headline)
                    }
                }
            }.disabled(formValidation())
            
        }
        .frame(width: UIScreen.main.bounds.width - 80, height: 350, alignment: .center)
        .padding(20)
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10)
        .stroke(Color.gray, lineWidth: 1))
        .navigationBarTitle(Text(getNavName()), displayMode: .inline)
        .alert(isPresented:$showingAlert) {
            Alert(title: Text("The details has been updated."), message: Text(""), dismissButton: .default(Text("OK")) {
                self.presentationMode.wrappedValue.dismiss()
                })
        }
    }


}

struct UpdateProfile_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProfile()
    }
}
