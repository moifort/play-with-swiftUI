import SwiftUI

struct EditTastingSheetView: View {
    var update : (String, String, String, Int?, Int?) -> Void = {_, _,_,_,_ in}
    let isTextureDisplay : Bool
    @Environment(\.presentationMode) var presentationMode
    
    @State var id : String = ""
    @State var methodId  = CoffeeMethod.default.id
    @State var coffee  = ""
    @State var grindSize  = 0
    @State var weight  = 0
    @State var time : Int? = nil
    
    
    var body: some View {
        NavigationView {
            TastingSheetForm(id: $id,
                             methodId: $methodId,
                             grindSize: $grindSize,
                             coffee: $coffee,
                             time: $time,
                             weight: $weight)
                .navigationBarTitle(Text("Edit Sheet"), displayMode: .inline)
                .navigationBarItems(leading: cancelButton, trailing: saveButton)
        }
    }
    
    
    var saveButton: some View {
        Button(action: {
            self.update(self.id,
                        self.methodId,
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

#if DEBUG
struct EditTastingSheetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EditTastingSheetView(isTextureDisplay: true)
            EditTastingSheetView(isTextureDisplay: true).environment(\.locale, Locale(identifier: "fr"))
        }
        
    }
}
#endif
