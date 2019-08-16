import SwiftUI

struct EditTastingSheetView: View {
    var update : (String, String, String, Int?, Int?) -> Void = {_, _,_,_,_ in}
    @Environment(\.presentationMode) var presentationMode
    
    @State var id : String = ""
    @State var method : Method = Method.moka
    @State var coffee : String = ""
    @State var grindSize : Int? = nil
    @State var weight : Int? = nil
    @State var time : Int? = nil
    
    
    var body: some View {
        NavigationView {
            TastingSheetForm(id: $id,
                             method: $method,
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
                        self.method.rawValue,
                        self.coffee,
                        self.grindSize,
                        self.weight)
            self.presentationMode.value.dismiss()
        }, label: { Text("Edit") }).disabled($coffee.value.count == 0)
    }
    
    var cancelButton: some View {
        Button(action: { self.presentationMode.value.dismiss() },
               label: { Text("Cancel") })
    }
}

#if DEBUG
struct EditTastingSheetView_Previews: PreviewProvider {
    static var previews: some View {
        EditTastingSheetView().environment(\.locale, Locale(identifier: "fr"))
    }
}
#endif
