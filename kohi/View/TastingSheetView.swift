import SwiftUI

struct TastingSheetView: View {
    var tastingSheet: TastingSheet
    var update : (String, String, String, Int?, Int?) -> () = {_, _,_,_,_ in}
    @State var showingNewTastingSheet = false
    
    var body: some View {
        Form {
            Section(header: Text("METHOD")) {
                HStack(alignment: .top) {
                    MethodImage(image: tastingSheet.method.image)
                    VStack(alignment: .leading) {
                        Text(tastingSheet.method.label.capitalized).font(.headline)
                    }.padding(.leading)
                }.padding(.all)
            }
            
          /*  Section(header: Text("COFFEE")) {
                VStack(alignment: .leading) {
                    Text("Name").foregroundColor(.secondary).font(.subheadline)
                    Text(tastingSheet.coffee)
                }
                
                if (tastingSheet.coffeeGrindSize != nil) {
                    VStack(alignment: .leading) {
                        Text("Grind size").foregroundColor(.secondary).font(.subheadline)
                        Text("\(tastingSheet.coffeeGrindSize!)")
                    }
                }
                if (tastingSheet.coffeeWeightInGrams != nil) {
                    VStack(alignment: .leading) {
                        Text("Weight").foregroundColor(.secondary).font(.subheadline)
                        Text("\(tastingSheet.coffeeWeightInGrams!) ") + Text("grams")
                    }
                }
            }*/
        }.navigationBarTitle(Text("Detail"), displayMode: .inline)
            .navigationBarItems(trailing: editButton)
            .sheet(isPresented: $showingNewTastingSheet) {
                EditTastingSheetView(update: self.update,
                                     isTextureDisplay: true,
                                     id: self.tastingSheet.id,
                                     methodId: self.tastingSheet.method.id,
                                     coffee: self.tastingSheet.coffee,
                                     grindSize: self.tastingSheet.coffeeGrindSize == nil ? 0 : self.tastingSheet.coffeeGrindSize!,
                                     weight: self.tastingSheet.coffeeWeightInGrams == nil ? 0 : self.tastingSheet.coffeeWeightInGrams!)
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
