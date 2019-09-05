import SwiftUI

struct TestingSheetRow : View {
    let grindMeasure : GrindMeasure
    let tastingSheet: TastingSheet
    
    var body: some View {
        HStack(alignment: .top) {
            MethodImage(image: tastingSheet.method.image)
            VStack(alignment: .leading, spacing: 4) {
                HStack{
                    Text(tastingSheet.coffee)
                }.lineLimit(1)
                HStack {
                    VStack(spacing: 3) {
                        if (tastingSheet.coffeeGrindSize != nil) {
                            HStack {
                                Image(systemName: "circle.grid.hex.fill")
                                if (grindMeasure == .metric) {
                                    Text("\(tastingSheet.coffeeGrindSize!)")
                                } else {
                                    Text(GrindTexture.fromSize(size: tastingSheet.coffeeGrindSize!).label.capitalized)
                                }
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
                    }
                }.foregroundColor(.secondary)
            }
        }
    }
}


#if DEBUG
struct TestingSheetRow_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            TestingSheetRow(grindMeasure: .texture, tastingSheet: TastingSheet(
                                                       id: "id",
                                                       method: CoffeeMethod.chemex,
                                                       coffee: "OUaaaa qsdjkl qslkj qdslkj qsdlkj qsldkj qslkjd qlskjd qskj qsdklj",
                                                       coffeeGrindSize: nil,
                                                       coffeeWeightInGrams: nil,
                                                       coffeeInfusionTimeInSeconds: nil,
                                                       waterQuantityInMilliliters: nil,
                                                       waterTemperatureInCelsius: nil,
                                                       tasteRatingOutOf5: nil)).previewLayout(.sizeThatFits)
            
            TestingSheetRow(grindMeasure: .texture,tastingSheet: TastingSheet(
                                                       id: "id",
                                                       method: CoffeeMethod.moka,
                                                       coffee: "OUaaaa",
                                                       coffeeGrindSize: nil,
                                                       coffeeWeightInGrams: nil,
                                                       coffeeInfusionTimeInSeconds: nil,
                                                       waterQuantityInMilliliters: nil,
                                                       waterTemperatureInCelsius: nil,
                                                       tasteRatingOutOf5: nil)).previewLayout(.sizeThatFits)
            
            TestingSheetRow(grindMeasure: .texture, tastingSheet: TastingSheet(
                                                       id: "id",
                                                       method: CoffeeMethod.aeropress,
                                                       coffee: "OUaaaa",
                                                       coffeeGrindSize: 20,
                                                       coffeeWeightInGrams: 150,
                                                       coffeeInfusionTimeInSeconds: 120,
                                                       waterQuantityInMilliliters: 10,
                                                       waterTemperatureInCelsius: 75,
                                                       tasteRatingOutOf5: 5)).previewLayout(.sizeThatFits)
            
            TestingSheetRow(grindMeasure: .metric,tastingSheet: TastingSheet(
                                                       id: "id",
                                                       method: CoffeeMethod.v60,
                                                       coffee: "OUaaaa",
                                                       coffeeGrindSize: 20,
                                                       coffeeWeightInGrams: 150,
                                                       coffeeInfusionTimeInSeconds: 120,
                                                       waterQuantityInMilliliters: 10,
                                                       waterTemperatureInCelsius: 75,
                                                       tasteRatingOutOf5: 5)).environment(\.colorScheme, .dark).previewLayout(.sizeThatFits)
        }
        
        
        
    }
}
#endif
