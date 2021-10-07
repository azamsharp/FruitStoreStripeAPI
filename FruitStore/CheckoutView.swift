//
//  CheckoutView.swift
//  FruitStore
//
//  Created by Mohammad Azam on 10/6/21.
//

import SwiftUI
import Stripe

struct CheckoutView: View {
    
    @EnvironmentObject private var cart: Cart
    @State private var message: String = ""
    @State private var isSuccess: Bool = false
    @State private var paymentMethodParams: STPPaymentMethodParams?
    let paymentGatewayController = PaymentGatewayController()
        
    private func pay() {
        
        guard let clientSecret = PaymentConfig.shared.paymentIntentClientSecret else {
            return
        }
        
        let paymentIntentParams = STPPaymentIntentParams(clientSecret: clientSecret)
        paymentIntentParams.paymentMethodParams = paymentMethodParams
        
        paymentGatewayController.submitPayment(intent: paymentIntentParams) { status, intent, error in
            
            switch status {
                case .failed:
                    message = "Failed"
                case .canceled:
                    message = "Cancelled"
                case .succeeded:
                    message = "Your payment has been successfully completed!"
            }
            
        }
        
    }

    var body: some View {
        VStack {
            List {
                
                ForEach(cart.items) { item in
                    HStack {
                        Text(item.photo)
                        Spacer()
                        Text(formatPrice(item.price) ?? "")
                    }
                }
                
                HStack {
                    Spacer()
                    Text("Total \(formatPrice(cart.cartTotal) ?? "")")
                    Spacer()
                }
                
                Section {
                    // Stripe Credit Card TextField Here
                    STPPaymentCardTextField.Representable.init(paymentMethodParams: $paymentMethodParams)
                } header: {
                    Text("Payment Information")
                }
                
                HStack {
                    Spacer()
                    Button("Pay") {
                        pay()
                    }.buttonStyle(.plain)
                    Spacer()
                }
                
                Text(message)
                    .font(.headline)
                
                
            }
            
            NavigationLink(isActive: $isSuccess, destination: {
                Confirmation()
            }, label: {
                EmptyView() 
            })
            
            
            .navigationTitle("Checkout")
            
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheckoutView().environmentObject(Cart())
        }
    }
}
