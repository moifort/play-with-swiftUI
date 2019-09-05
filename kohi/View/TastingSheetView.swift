import SwiftUI

struct TastingSheetView: View {
    @EnvironmentObject private var preferenceStore: PreferenceStore
    
    var tastingSheet: TastingSheet
    var update : (String, String, String, Int?, Int?) -> () = {_, _,_,_,_ in}
    @State var showingNewTastingSheet = false
    
    var body: some View {
        TastingSheetFormRead(grindMeasure: preferenceStore.preference.grindMeasure,
                             id: tastingSheet.id,
                             coffeeMethod: tastingSheet.method,
                             grindSize: tastingSheet.coffeeGrindSize,
                             coffee: tastingSheet.coffee,
                             weight: tastingSheet.coffeeWeightInGrams)
            .navigationBarTitle(Text("Detail"), displayMode: .inline)
            .navigationBarItems(trailing: editButton)
            .sheet(isPresented: $showingNewTastingSheet) {
                EditTastingSheetView(update: self.update,
                                     isTextureDisplay: true,
                                     id: self.tastingSheet.id,
                                     coffeeMethod: self.tastingSheet.method,
                                     coffee: self.tastingSheet.coffee,
                                     grindSize: self.tastingSheet.coffeeGrindSize == nil ? 0 : self.tastingSheet.coffeeGrindSize!,
                                     weight: self.tastingSheet.coffeeWeightInGrams == nil ? 0 : self.tastingSheet.coffeeWeightInGrams!).environmentObject(self.preferenceStore)
        }
    }
    
    var editButton: some View {
        Button(action: { self.showingNewTastingSheet.toggle() })  {
            Text("Edit")
        }
    }
}


struct TastingSheetView_Previews: PreviewProvider {
    static let tastingSheet = TastingSheet(id: "id",
                                           method: CoffeeMethod.aeropress,
                                           coffee: "Voluto",
                                           coffeeGrindSize: 20,
                                           coffeeWeightInGrams: 150,
                                           coffeeInfusionTimeInSeconds: 120,
                                           waterQuantityInMilliliters: 10,
                                           waterTemperatureInCelsius: 75,
                                           tasteRatingOutOf5: 5)
    
    static var previews: some View {
        Group {
            TastingSheetView(tastingSheet: tastingSheet).environment(\.colorScheme, .dark)
            TastingSheetView(tastingSheet: tastingSheet).environment(\.locale, Locale(identifier: "fr"))
        }
        
    }
}
