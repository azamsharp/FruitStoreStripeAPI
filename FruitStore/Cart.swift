//
//  Cart.swift
//  FruitStore
//
//  Created by Mohammad Azam on 10/6/21.
//

import Foundation

class Cart: ObservableObject {
    
    @Published private(set) var items: [Product] = [Product]()
    
    var cartTotal: Double {
        return items.reduce(0) { result, product in
            result + product.price
        }
    }
    
    var cartCount: Int {
        items.count 
    }
    
    func addToCart(_ item: Product) {
        items.append(item)
    }
}
