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
    @Binding var grindSize : Int?
    @Binding var coffee : String
    @Binding var time: Int?
    @Binding var weight: Int?
    
    var body: some View {
        Form {
            Picker("Method", selection: $method) {
                ForEach(Method.allCases, id: \.self) { method in
                    Text(method.rawValue).tag(method)
                }
            }
            
            Section(header: Text("COFFEE")) {
                HStack {
                    Text("Name").foregroundColor(.secondary)
                    Spacer()
                    TextField("", text: $coffee).multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Grind size").foregroundColor(.secondary)
                    Spacer()
                    TextField("", value: $grindSize, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Weight").foregroundColor(.secondary)
                    Spacer()
                    TextField("", value: $weight, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                }
            }
            
            
            //   Section(header: Text("COFFEE")) {
            //      HStack {
            //          Text("Name").foregroundColor(.secondary)
            //          Spacer()
            //          TextField("", text: $coffee)
            //              .multilineTextAlignment(.trailing)
            //      }
            //     HStack {
            //         Text("Grind size").foregroundColor(.secondary)
            //         Spacer()
            //         TextField("", text: $grindSize)
            //          //   .keyboardType(.numberPad)
            //             .multilineTextAlignment(.trailing)
            //
            //     }
            //     HStack {
            //         Text("Grams").foregroundColor(.secondary)
            //         Spacer()
            //         TextField("", text: $weight)
            //             //.keyboardType(.numberPad)
            //             .multilineTextAlignment(.trailing)
            //
            //     }
            //  }
            //
            //     Section(header: Text("WATER")) {
            //         HStack {
            //             Text("Milliliter").foregroundColor(.secondary)
            //             Spacer()
            //             TextField("", value: $milliliter , formatter: NumberFormatter())
            //                 .keyboardType(.numberPad)
            //                 .multilineTextAlignment(.trailing)
            //
            //         }
            //         HStack {
            //             Text("°C").foregroundColor(.secondary)
            //             Spacer()
            //             TextField("", value: $celsius, formatter: NumberFormatter())
            //                 .keyboardType(.numberPad)
            //                 .multilineTextAlignment(.trailing)
            //
            //         }
            //     }
            //
            //     HStack {
            //         Spacer()
            //         Image(systemName: "star.fill")
            //         Image(systemName: "star.fill")
            //         Image(systemName: "star.fill")
            //         Image(systemName: "star.fill")
            //         Image(systemName: "star.fill")
            //         Spacer()
            //     }
            //
            //
            
        }
    }
}


#if DEBUG
struct TastingSheetForm_Previews: PreviewProvider {
    static var previews: some View {
        TastingSheetForm(id: .constant("id"),
                         method: .constant(Method.aeropress),
                         grindSize: .constant(nil),
                         coffee: .constant(""),
                         time: .constant(nil),
                         weight: .constant(nil)).environment(\.locale, Locale(identifier: "fr"))
    }
}
#endif
