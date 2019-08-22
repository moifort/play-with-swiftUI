import SwiftUI

struct TastingSheetView: View {
    var tastingSheet: TastingSheet
    var update : (String, String, String, Int?, Int?) -> () = {_, _,_,_,_ in}
    @State var showingNewTastingSheet = false
    
    var body: some View {
        Form {
            Section(header: Text("METHOD")) {
                HStack(alignment: .top) {
                    Image(tastingSheet.method.rawValue)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 6)
                    VStack(alignment: .leading) {Text(tastingSheet.method.rawValue.capitalizingFirstLetter()) }.padding(.leading)
                }.padding(.all)
            }
            
            Section(header: Text("COFFEE")) {
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
            }
        }.navigationBarTitle(Text("Detail"), displayMode: .inline)
            .navigationBarItems(trailing: editButton)
            .sheet(isPresented: $showingNewTastingSheet) {
                EditTastingSheetView(update: self.update, id: self.tastingSheet.id, method: self.tastingSheet.method, coffee: self.tastingSheet.coffee, grindSize: self.tastingSheet.coffeeGrindSize, weight: self.tastingSheet.coffeeWeightInGrams)
            }
    }
    
    var editButton: some View {
           Button(action: { self.showingNewTastingSheet.toggle() })  {
               Text("Edit")
           }
       }
}

#if DEBUG
struct TastingSheetView_Previews: PreviewProvider {
    static let tastingSheet = TastingSheet(id: "id",
                                           method: Method.chemex,
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
#endif


extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
