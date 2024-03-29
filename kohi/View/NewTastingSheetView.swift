import SwiftUI

struct NewTastingSheetView: View {
    @EnvironmentObject private var preferenceStore: PreferenceStore
    @Environment(\.presentationMode) var presentationMode
    
    var add : (String, String, Int?, Int?) -> Void = {_, _, _, _ in }
    @State var id : String = ""
    @State var coffeeMethod = CoffeeMethod.default
    @State var grindSize = 20
    @State var coffee = ""
    @State var weight = 40
    @State var time : Int? = nil
    
    var body: some View {
        NavigationView {
            TastingSheetFormWrite(grindMeasure: preferenceStore.preference.grindMeasure,
                                  id: $id,
                                  coffeeMethod: $coffeeMethod,
                                  grindSize: $grindSize,
                                  coffee: $coffee,
                                  weight: $weight)
                .navigationBarTitle(Text("New sheet"), displayMode: .inline)
                .navigationBarItems(leading: cancelButton, trailing: addButton)
        }
    }
    
    var cancelButton: some View {
        Button(action: { self.presentationMode.wrappedValue.dismiss() },
               label: { Text("Cancel") })
    }
    
    var addButton: some View {
        Button(action: {
            self.add(self.coffeeMethod.id, self.coffee, self.grindSize, self.weight)
            self.presentationMode.wrappedValue.dismiss()
        }, label: { Text("Add") }).disabled(self.coffee.count == 0)
    }
}

#if DEBUG
struct NewTastingSheetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NewTastingSheetView()
            NewTastingSheetView().environment(\.locale, Locale(identifier: "fr"))
        }
        
    }
}
#endif
