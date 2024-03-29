import SwiftUI
import Firebase

struct TastingSheetListView: View {
    @EnvironmentObject private var userStore: UserStore
    @EnvironmentObject private var tastingSheetsStore: TastingSheetsStore
    @EnvironmentObject private var preferenceStore: PreferenceStore
    
    @State var showingNewTastingSheet = false
    @State var showingPreferences = false
    
    var addButton: some View {
        Button(action: { self.showingNewTastingSheet.toggle() }) {
            Text("Add Sheet")
        }.sheet(isPresented: $showingNewTastingSheet) {
            NewTastingSheetView(add: self.tastingSheetsStore.add).environmentObject(self.preferenceStore)
        }
    }
    
    var preferencesButton: some View {
        Button(action: { self.showingPreferences.toggle() }) {
            Image(systemName: "person.circle").imageScale(.large).padding(15)
        }.sheet(isPresented: $showingPreferences) {
            PreferencesView(logout: self.userStore.logout,
                            update: self.preferenceStore.update,
                            grindMeasureId: self.preferenceStore.preference.grindMeasure.id)
            
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(tastingSheetsStore.tastingSheets) { tastingSheet in
                    NavigationLink(destination: TastingSheetView(tastingSheet: tastingSheet, update: self.tastingSheetsStore.update)) {
                        TestingSheetRow(grindMeasure: self.preferenceStore.preference.grindMeasure, tastingSheet: tastingSheet).padding(.all, 5)
                    }
                }.onDelete { indexSet in
                    let toDelete = self.tastingSheetsStore.tastingSheets[indexSet.first!]
                    self.tastingSheetsStore.delete(id: toDelete.id)
                }
            }
            .navigationBarTitle(Text("Tasting sheets"))
            .navigationBarItems(leading: preferencesButton, trailing: addButton)
        }.onAppear() {
            self.tastingSheetsStore.fetchAndListen(userId: self.userStore.userId)
            self.preferenceStore.fetchAndListen(userId: self.userStore.userId)
        }
    }
}


#if DEBUG
struct TastingSheetListView_Previews: PreviewProvider {
    static let sheets = [
        TastingSheet(id: "00",
                     method: CoffeeMethod.aeropress,
                     coffee: "Brazilia",
                     coffeeGrindSize: 18,
                     coffeeWeightInGrams: 150,
                     coffeeInfusionTimeInSeconds: 120,
                     waterQuantityInMilliliters: 150,
                     waterTemperatureInCelsius: 75,
                     tasteRatingOutOf5: 5),
        TastingSheet(id: "01",
                     method: CoffeeMethod.aeropress,
                     coffee: "Voluto",
                     coffeeGrindSize: 25,
                     coffeeWeightInGrams: 200,
                     coffeeInfusionTimeInSeconds: 130,
                     waterQuantityInMilliliters: 45,
                     waterTemperatureInCelsius: 80,
                     tasteRatingOutOf5: 5),
        TastingSheet(id: "02",
                     method: CoffeeMethod.moka,
                     coffee: "Brazila from testotesra",
                     coffeeGrindSize: 20,
                     coffeeWeightInGrams: 150,
                     coffeeInfusionTimeInSeconds: 120,
                     waterQuantityInMilliliters: 10,
                     waterTemperatureInCelsius: 75,
                     tasteRatingOutOf5: 5)
    ]
    
    static let store = TastingSheetsStore(tastingSheets: sheets)
    
    static var previews: some View {
        Group {
            TastingSheetListView()
            TastingSheetListView().environment(\.locale, Locale(identifier: "fr"))
            TastingSheetListView().environment(\.colorScheme, .dark)
            TastingSheetListView().previewDevice("iPhone SE")
        }.environmentObject(store)
            .environmentObject(UserStore())
    }
}
#endif


