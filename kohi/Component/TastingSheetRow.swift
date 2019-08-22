import SwiftUI

struct TestingSheetRow : View {
    @Environment(\.colorScheme) var dark :ColorScheme
    var tastingSheet: TastingSheet
    
    var body: some View {
        HStack(alignment: .top) {
            Image(tastingSheet.method.rawValue)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 6)
                .padding(.trailing, 10)
                .contrast(dark == ColorScheme.dark ? -1 : 1)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack{
                    Text(tastingSheet.coffee).font(.headline)
                }.lineLimit(1)
                HStack {
                    VStack(spacing: 2) {
                        if (tastingSheet.coffeeGrindSize != nil) {
                            HStack {
                                Image(systemName: "circle.grid.hex.fill")
                                Text("\(tastingSheet.coffeeGrindSize!)")
                                Spacer()
                            }
                        }
                        if (tastingSheet.coffeeWeightInGrams != nil) {
                            HStack {
                                Image(systemName: "g.circle")
                                Text("\(tastingSheet.coffeeWeightInGrams!)g")
                                Spacer()
                            }
                        }
                        if (tastingSheet.coffeeInfusionTimeInSeconds != nil) {
                            HStack {
                                Image(systemName: "alarm")
                                Text("\(tastingSheet.coffeeInfusionTimeInSeconds!)s")
                                Spacer()
                            }
                        }
                    }
                }.font(.caption).foregroundColor(.secondary)
            }
        }
    }
}

/* VStack(alignment: .leading, spacing: 4) {
 VStack(alignment: .leading){
 Text(tastingSheet.coffee).font(.headline)
 }.lineLimit(1)
 
 HStack(alignment: .top) {
 VStack(spacing: 4) {
 if (tastingSheet.coffeeGrindSize != nil) {
 HStack {
 Image(systemName: "circle.grid.hex.fill")
 Text("\(tastingSheet.coffeeGrindSize!)")
 Spacer()
 }
 }
 if (tastingSheet.coffeeWeightInGrams != nil) {
 HStack {
 Image(systemName: "g.circle")
 Text("\(tastingSheet.coffeeWeightInGrams!)g")
 Spacer()
 }
 }
 if (tastingSheet.coffeeInfusionTimeInSeconds != nil) {
 HStack {
 Image(systemName: "alarm")
 Text("\(tastingSheet.coffeeInfusionTimeInSeconds!)s")
 Spacer()
 }
 }
 Spacer()
 }.font(.caption).foregroundColor(.secondary)
 VStack(spacing: 4) {
 if (tastingSheet.waterQuantityInMilliliters != nil) {
 HStack {
 Image(systemName: "rhombus")
 Text("\(tastingSheet.waterQuantityInMilliliters!)ml")
 Spacer()
 }
 }
 if (tastingSheet.waterTemperatureInCelsius != nil) {
 HStack {
 Image(systemName: "thermometer")
 Text(" \(tastingSheet.waterTemperatureInCelsius!)°C")
 Spacer()
 }
 }
 Spacer()
 }.font(.caption).foregroundColor(.secondary)
 
 }
 
 }.padding(.leading, 10)*/




#if DEBUG
struct TestingSheetRow_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            TestingSheetRow(tastingSheet: TastingSheet(id: "id",
                                                       method: Method.chemex,
                                                       coffee: "OUaaaa qsdjkl qslkj qdslkj qsdlkj qsldkj qslkjd qlskjd qskj qsdklj",
                                                       coffeeGrindSize: nil,
                                                       coffeeWeightInGrams: nil,
                                                       coffeeInfusionTimeInSeconds: nil,
                                                       waterQuantityInMilliliters: nil,
                                                       waterTemperatureInCelsius: nil,
                                                       tasteRatingOutOf5: nil)).previewLayout(.sizeThatFits)
            
            TestingSheetRow(tastingSheet: TastingSheet(id: "id",
                                                       method: Method.chemex,
                                                       coffee: "OUaaaa",
                                                       coffeeGrindSize: nil,
                                                       coffeeWeightInGrams: nil,
                                                       coffeeInfusionTimeInSeconds: nil,
                                                       waterQuantityInMilliliters: nil,
                                                       waterTemperatureInCelsius: nil,
                                                       tasteRatingOutOf5: nil)).previewLayout(.sizeThatFits)
            
            TestingSheetRow(tastingSheet: TastingSheet(id: "id",
                                                       method: Method.chemex,
                                                       coffee: "OUaaaa",
                                                       coffeeGrindSize: 20,
                                                       coffeeWeightInGrams: 150,
                                                       coffeeInfusionTimeInSeconds: 120,
                                                       waterQuantityInMilliliters: 10,
                                                       waterTemperatureInCelsius: 75,
                                                       tasteRatingOutOf5: 5)).previewLayout(.sizeThatFits)
            
            TestingSheetRow(tastingSheet: TastingSheet(id: "id",
                                                       method: Method.chemex,
                                                       coffee: "OUaaaa",
                                                       coffeeGrindSize: 20,
                                                       coffeeWeightInGrams: 150,
                                                       coffeeInfusionTimeInSeconds: 120,
                                                       waterQuantityInMilliliters: 10,
                                                       waterTemperatureInCelsius: 75,
                                                       tasteRatingOutOf5: 5)).previewLayout(.sizeThatFits).environment(\.colorScheme, .dark)
        }
        
        
        
    }
}
#endif
