//
//  FruitStoreApp.swift
//  FruitStore
//
//  Created by Mohammad Azam on 10/6/21.
//

import SwiftUI
import Stripe

@main
struct FruitStoreApp: App {
    
    init() {
        StripeAPI.defaultPublishableKey = "YOURPUBLISHABLEKEY"
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(Cart())
        }
    }
}
