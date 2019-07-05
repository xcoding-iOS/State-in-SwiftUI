//
//  ContentView.swift
//  State
//
//  Created by Giuseppe Sapienza on 01/07/2019.
//  Copyright © 2019 Giuseppe Sapienza. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    
    @State var priceText: String = ""
    @State var vatValue: Int = 22
    @State var newTaxValue: Int = 0
    @State var addNewTax: Bool = false
    
    var priceNumber: Double? {
        Double(priceText)
    }
    
    var resultPrice: Double? {
        guard let price = priceNumber else {
            return nil
        }
        
        var result = price
            + (price * Double(vatValue)/100)
        
        if (addNewTax) {
            result += (price * Double(newTaxValue)/100)
        }
        
        return result
    }
    
    var resultText: String {
        String(format: "%.2f", resultPrice ?? 0)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("VAT Calculator")
                .font(.title)
            
            TextField("Price", text: $priceText)
                .textFieldStyle(.roundedBorder)
                .border(priceNumber == nil ? Color.red : Color.green)
            
            if priceNumber != nil {
                
                Stepper(value: $vatValue, in: 0...100) {
                    Text("VAT Value: \(vatValue) %")
                }
                
                Toggle(isOn: $addNewTax) {
                    Text("Add new Tax?")
                }
                .padding(.top, 20)
                
                if addNewTax {
                    Stepper(value: $newTaxValue, in: 0...100) {
                        Text("Tax Value: \(newTaxValue) %")
                    }
                    .padding(.bottom, 20)
                }

                (Text("Result: ")
                +
                Text(resultText)
                    .font(.system(size: 24))
                    .fontWeight(.bold))
                
                
            }
            
            Spacer()
        }
        .padding()
    }
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView(priceText: "10", newTaxValue: 10)
    }
}
#endif
