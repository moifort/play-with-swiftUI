
import SwiftUI

struct TastingSheetFormRead: View {
    let grindMeasure : GrindMeasure
    
    let id : String
    let coffeeMethod : CoffeeMethod
    let grindSize : Int?
    let coffee : String
    let weight: Int?
    
    var body: some View {
        Form {
            Section(header: Text("METHOD")) {
                HStack(alignment: .top) {
                    MethodImage(image: coffeeMethod.image)
                    VStack(alignment: .leading) {
                        Text(coffeeMethod.label.capitalized).font(.headline)
                    }.padding(.leading)
                }.padding(.all)
            }
            
            
            Section(header: Text("COFFEE")) {
                VStack(alignment: .leading) {
                    Text("Name").foregroundColor(.secondary).font(.subheadline)
                    Text(coffee)
                }
                
                if (grindSize != nil) {
                    GrindSizeField(editMode: .inactive, grindMeasure: grindMeasure, grindSize: .constant(grindSize!))
                }
                
                if (weight != nil) {
                    VStack(alignment: .leading) {
                        Text("Weight").foregroundColor(.secondary).font(.subheadline)
                        Text("\(weight!) ") + Text("grams")
                    }
                }
            }
        }
    }
    
}


struct TastingSheetFormRead_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TastingSheetFormRead(grindMeasure: GrindMeasure.texture,
                                 id: "id",
                                 coffeeMethod: CoffeeMethod.moka,
                                 grindSize: 25,
                                 coffee: "Voluto",
                                 weight: 45).environment(\.locale, Locale(identifier: "fr"))
            TastingSheetFormRead(grindMeasure: GrindMeasure.metric,
                                 id: "id",
                                 coffeeMethod: CoffeeMethod.aeropress,
                                 grindSize: 12,
                                 coffee: "Voluto Brazil",
                                 weight: 45)
        }
        
    }
}

