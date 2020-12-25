//
//  UserProfile.swift
//  SwiftUIRestaurantDemo
//
//  Created by PCQ224 on 23/12/20.
//  Copyright © 2020 PCQ224. All rights reserved.
//

import SwiftUI

struct UserProfile: View {
    
    @State var email: String = "vinaytiwarij88@gmail.com"
    @State var phoneNumber: String = "7359406282"
    @State var isDisable = true
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage(imageLiteralResourceName: "menImage")
    
    var body: some View {
        NavigationView {
            VStack(alignment:.center) {
                ZStack(alignment: .bottom) {
                    Image(uiImage: self.image)
                        //                    Image("menImage")
                        .resizable()
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200)
                    Button(action: {
                        self.isShowPhotoLibrary = true
                    }) {
                        Image(systemName: "pencil.circle")
                            .foregroundColor(.green)
                            .shadow(color: .orange, radius: 10, x: 1, y: 1)
                            .padding(-5)
                    }
                }
                Text("Vinay Tiwari")
                Spacer()
                Divider()
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .padding(.leading, 20)
                    TextField("Email", text: $email)
                        .textFieldStyle(PlainTextFieldStyle())
                        .disabled(isDisable)
                    
                    NavigationLink(destination: UpdateProfile(choice: .email)) {
                        HStack {
                            Image(systemName: "pencil.circle")
                                .foregroundColor(.red)
                                .padding(20)
                            
                            //                            Text("UPDATE")
                            //                                .frame(minWidth: 30, maxWidth: 65)
                            //                                .padding(12)
                            //                                .foregroundColor(.white)
                            //                                .background(Color.red)
                            //                                .font(.subheadline)
                            
                        }.padding(10)
                    }
                }
                Divider()
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .padding(.leading, 20)
                    
                    TextField("Phone", text: $phoneNumber)
                        .textFieldStyle(PlainTextFieldStyle())
                        .disabled(isDisable)
                    
                    NavigationLink(destination: UpdateProfile(choice: .phone)) {
                        HStack {
                            Image(systemName: "pencil.circle")
                                .foregroundColor(.red)
                                .padding(20)
                            
                            //                            Text("UPDATE")
                            //                                .frame(minWidth: 30, maxWidth: 65)
                            //                                .padding(12)
                            //                                .foregroundColor(.white)
                            //                                .background(Color.red)
                            //                                .font(.subheadline)
                            
                        }.padding(10)
                    }
                }
                Spacer()
                
                NavigationLink(destination: UpdateProfile(choice: .password)) {
                    HStack {
                        Text("CHANGE PASSWORD")
                            .frame(minWidth: 30, maxWidth: UIScreen.main.bounds.width - 20)
                            .padding(12)
                            .foregroundColor(.white)
                            .background(Color.red)
                            .font(.subheadline)
                        
                    }.padding(10)
                }
                // Spacer()
            }
            .navigationBarTitle("Profile")
            .navigationBarItems(trailing:
                
                NavigationLink(destination: AddressView()) {
                    VStack(alignment: .center, spacing: 20)  {
                        Image(systemName: "location.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25)
                            .accentColor(.red)
                    }
                }
            )
                .sheet(isPresented: $isShowPhotoLibrary) {
                    ImagePicker(sourceType: .photoLibrary,selectedImage: self.$image)
            }
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
