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
    
    var priceNumber: Double? {
        Double(priceText)
    }
    
    var resultPrice: Double? {
        guard let price = priceNumber else {
            return nil
        }
        
        let result = price + (price * Double(vatValue)/100)
        return result
    }
    
    var resultText: String {
        String(format: "%.2f", resultPrice ?? 0)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("VAT Calculator")
                .font(.title)
            
            TextField($priceText, placeholder: Text("Inserisci il prezzo"))
                .textFieldStyle(.roundedBorder)
                .border(priceNumber == nil ? Color.red : Color.green)
            
            Stepper(value: $vatValue, in: 0...100) {
                Text("VAT Value: \(vatValue) %")
            }
            
            if resultPrice != nil {
                Text("Result: ")
                +
                Text(resultText)
                    .font(.system(size: 24))
                    .fontWeight(.bold)
            }
            
            Spacer()
        }
        .padding()
    }
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView(priceText: "123")
    }
}
#endif
