
import SwiftUI

struct TastingSheetFormWrite: View {
    let grindMeasure : GrindMeasure
    
    @Binding var id : String
    @Binding var coffeeMethod : CoffeeMethod
    @Binding var grindSize : Int
    @Binding var coffee : String
    @Binding var weight: Int
    
    var body: some View {
        Form {
            Picker("Method", selection: $coffeeMethod) {
                ForEach(CoffeeMethod.allCases.sorted { $0.label < $1.label }) { method in
                   Text(method.label.capitalized).tag(method)
                }
            }
            
            Section(header: Text("COFFEE")) {
                HStack {
                    TextField("Name", text: $coffee)
                }
                GrindSizeField(editMode: .active, grindMeasure: grindMeasure, grindSize: $grindSize)
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


struct TastingSheetFormWrite_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TastingSheetFormWrite(grindMeasure: GrindMeasure.texture,
                             id: .constant("id"),
                             coffeeMethod: .constant(CoffeeMethod.moka),
                             grindSize: .constant(25),
                             coffee: .constant("Voluto"),
                             weight: .constant(45)).environment(\.locale, Locale(identifier: "fr")).environment(\.colorScheme, .dark)
            TastingSheetFormWrite(grindMeasure: GrindMeasure.metric,
                             id: .constant("id"),
                             coffeeMethod: .constant(CoffeeMethod.aeropress),
                             grindSize: .constant(12),
                             coffee: .constant("Voluto Brazil"),
                             weight: .constant(45))
        }
        
    }
}

