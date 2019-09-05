import SwiftUI

struct EditTastingSheetView: View {
    @EnvironmentObject private var preferenceStore: PreferenceStore
    @Environment(\.presentationMode) var presentationMode
    
    var update : (String, String, String, Int?, Int?) -> Void = {_, _,_,_,_ in}
    let isTextureDisplay : Bool
    
    @State var id : String = ""
    @State var coffeeMethod  = CoffeeMethod.default
    @State var coffee  = ""
    @State var grindSize  = 0
    @State var weight  = 0
    @State var time : Int? = nil
    
    
    var body: some View {
        NavigationView {
            TastingSheetFormWrite(grindMeasure: preferenceStore.preference.grindMeasure,
                                  id: $id,
                                  coffeeMethod: $coffeeMethod,
                                  grindSize: $grindSize,
                                  coffee: $coffee,
                                  weight: $weight)
                .navigationBarTitle(Text("Edit Sheet"), displayMode: .inline)
                .navigationBarItems(leading: cancelButton, trailing: saveButton)
        }
    }
    
    
    var saveButton: some View {
        Button(action: {
            self.update(self.id,
                        self.coffeeMethod.id,
                        self.coffee,
                        self.grindSize == 0 ? nil : self.grindSize,
                        self.weight == 0 ? nil : self.weight)
            self.presentationMode.wrappedValue.dismiss()
        }, label: { Text("Save") }).disabled(self.coffee.count == 0)
    }
    
    var cancelButton: some View {
        Button(action: { self.presentationMode.wrappedValue.dismiss() },
               label: { Text("Cancel") })
    }
}


struct EditTastingSheetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EditTastingSheetView(isTextureDisplay: true).environmentObject(PreferenceStore())
            EditTastingSheetView(isTextureDisplay: true).environment(\.locale, Locale(identifier: "fr")).environmentObject(PreferenceStore())
        }
        
    }
}
