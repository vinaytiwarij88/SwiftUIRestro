//
//  Addresses.swift
//  SwiftUIRestaurantDemo
//
//  Created by PCQ224 on 24/12/20.
//  Copyright © 2020 PCQ224. All rights reserved.
//

import Foundation

struct AddressSection: Codable {
    internal init(items: [Addresses]) {
        self.items = items
    }
    
    var items: [Addresses]
}

struct Addresses: Codable, Equatable,Hashable {
    var title: String
    var category: String
    var pinCode: String
    var address: String
}
