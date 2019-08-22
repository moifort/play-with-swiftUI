import SwiftUI

struct TastingSheetListView: View {
    @EnvironmentObject private var userStore: UserStore
    @EnvironmentObject private var tastingSheetsStore: TastingSheetsStore

    @State var showingNewTastingSheet = false
    
    var addButton: some View {
        Button(action: { self.showingNewTastingSheet.toggle() }) {
            Text("Add Sheet")
        }
    }
    
    var logoutButton: some View {
        Button(action: { self.userStore.logout() }) {
            Text("Logout")
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(tastingSheetsStore.tastingSheets) { tastingSheet in
                    NavigationLink(destination: TastingSheetView(tastingSheet: tastingSheet, update: self.tastingSheetsStore.update)) {
                    TestingSheetRow(tastingSheet: tastingSheet).padding(.all, 5)
                    }
                }.onDelete { indexSet in
                    let toDelete = self.tastingSheetsStore.tastingSheets[indexSet.first!]
                    self.tastingSheetsStore.delete(id: toDelete.id)
                }
            }
            .navigationBarTitle(Text("Tasting sheets"))
            .navigationBarItems(leading: logoutButton, trailing: addButton)
            .sheet(isPresented: $showingNewTastingSheet) { NewTastingSheetView(add: self.tastingSheetsStore.add) }
            
        }
    }
}


#if DEBUG
struct TastingSheetListView_Previews: PreviewProvider {
    static let sheets = [
        TastingSheet(id: "00",
                     method: Method.moka,
                     coffee: "Brazilia",
                     coffeeGrindSize: 18,
                     coffeeWeightInGrams: 150,
                     coffeeInfusionTimeInSeconds: 120,
                     waterQuantityInMilliliters: 150,
                     waterTemperatureInCelsius: 75,
                     tasteRatingOutOf5: 5),
        TastingSheet(id: "01",
                     method: Method.v60,
                     coffee: "Voluto",
                     coffeeGrindSize: 25,
                     coffeeWeightInGrams: 200,
                     coffeeInfusionTimeInSeconds: 130,
                     waterQuantityInMilliliters: 45,
                     waterTemperatureInCelsius: 80,
                     tasteRatingOutOf5: 5),
        TastingSheet(id: "02",
                     method: Method.aeropress,
                     coffee: "Brazila from testotesra",
                     coffeeGrindSize: 20,
                     coffeeWeightInGrams: 150,
                     coffeeInfusionTimeInSeconds: 120,
                     waterQuantityInMilliliters: 10,
                     waterTemperatureInCelsius: 75,
                     tasteRatingOutOf5: 5)
    ]
    
    static let store = TastingSheetsStore(userId: "", tastingSheets: sheets)
    
    static var previews: some View {
        Group {
            TastingSheetListView()
            TastingSheetListView().environment(\.locale, Locale(identifier: "fr"))
            TastingSheetListView().environment(\.colorScheme, .dark)
        }.environmentObject(store)
            .environmentObject(UserStore())
    }
}
#endif


