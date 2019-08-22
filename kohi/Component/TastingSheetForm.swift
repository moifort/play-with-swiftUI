//
//  TastingSheetForm.swift
//  kohi
//
//  Created by Thibaut on 13/08/2019.
//  Copyright © 2019 Thibaut. All rights reserved.
//

import SwiftUI

struct TastingSheetForm: View {
    @Binding var id : String
    @Binding var method : Method
    @Binding var grindSize : Int
    @Binding var coffee : String
    @Binding var time: Int?
    @Binding var weight: Int
    
    var body: some View {
        Form {
            Picker("Method", selection: $method) {
                ForEach(Method.allCases, id: \.self) { method in
                    Text(method.rawValue).tag(method)
                }
            }
            
            Section(header: Text("COFFEE")) {
                HStack {
                    TextField("Name", text: $coffee)
                }
                Stepper(value: $grindSize, in: 0...100) {
                    HStack {
                        Text("Grind")
                        Spacer()
                        Text("\(grindSize)")
                    }
                }
                Stepper(value: $weight, in: 0...200, step: 5) {
                    HStack {
                        Text("Weight (Gram)")
                        Spacer()
                        Text("\(weight)")
                    }
                }
            }
        }
    }
}


#if DEBUG
struct TastingSheetForm_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TastingSheetForm(id: .constant("id"),
                             method: .constant(Method.aeropress),
                             grindSize: .constant(20),
                             coffee: .constant(""),
                             time: .constant(nil),
                             weight: .constant(45)).environment(\.locale, Locale(identifier: "fr"))
            TastingSheetForm(id: .constant("id"),
                             method: .constant(Method.aeropress),
                             grindSize: .constant(12),
                             coffee: .constant(""),
                             time: .constant(20),
                             weight: .constant(45))
        }
        
    }
}
#endif
