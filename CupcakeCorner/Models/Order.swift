//
//  Order.swift
//  CupcakeCorner
//
//  Created by Rob Ranf on 8/3/23.
//

import SwiftUI

// Remember that we use a class here because a class passes values by reference (it points to
// the data in memory), so all the data is preserved between screens. If we used a struct, we'd
// lose the data because a struct passes data by copy.
class Order: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 3
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        return true
    }
}
