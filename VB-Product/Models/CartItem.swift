//
//  CartItem.swift
//  VB-Product
//
//  Created by My Mac on 20/06/23.
//

import Foundation

struct CartItem: Identifiable, Equatable {
    static func == (lhs: CartItem, rhs: CartItem) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: String { product.id }
    let product: Product
    var count: Int
}
