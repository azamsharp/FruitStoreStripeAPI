//
//  PaymentConfig.swift
//  FruitStore
//
//  Created by Mohammad Azam on 10/7/21.
//

import Foundation

class PaymentConfig {
    
    var paymentIntentClientSecret: String?
    static var shared: PaymentConfig = PaymentConfig()
    
    private init() { }
}
