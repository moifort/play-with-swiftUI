
import SwiftUI

struct TastingSheetForm: View {
    @Binding var id : String
    @Binding var methodId : String
    @Binding var grindSize : Int
    @Binding var coffee : String
    @Binding var time: Int?
    @Binding var weight: Int
    
    var body: some View {
        Form {
            Picker("Method", selection: $methodId) {
                ForEach(CoffeeMethod.allCases) { method in
                    Text(method.label).tag(method.id)
                }
            }
            
            Section(header: Text("COFFEE")) {
                HStack {
                    TextField("Name", text: $coffee)
                }
                GrindSizeField(grindSize: $grindSize)
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
                             methodId: .constant("moka"),
                             grindSize: .constant(20),
                             coffee: .constant(""),
                             time: .constant(nil),
                             weight: .constant(45)).environment(\.locale, Locale(identifier: "fr"))
            TastingSheetForm(id: .constant("id"),
                             methodId: .constant("aeropress"),
                             grindSize: .constant(12),
                             coffee: .constant(""),
                             time: .constant(20),
                             weight: .constant(45))
        }
        
    }
}
#endif

