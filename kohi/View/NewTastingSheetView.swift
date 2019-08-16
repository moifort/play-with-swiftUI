import SwiftUI

struct NewTastingSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    var add : (String, String, Int?, Int?) -> Void = {_, _, _, _ in }
    
    @State var id : String = ""
    @State var method : Method = Method.moka
    @State var grindSize : Int? = nil
    @State var coffee : String = ""
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
                .navigationBarTitle(Text("New tasting sheet"), displayMode: .inline)
                .navigationBarItems(leading: cancelButton, trailing: addButton)
        }
    }
    
    var cancelButton: some View {
        Button(action: { self.presentationMode.value.dismiss() },
               label: { Text("Cancel") })
    }
    
    var addButton: some View {
        Button(action: {
            self.add(self.method.rawValue, self.coffee, self.grindSize, self.weight)
            self.presentationMode.value.dismiss()
        }, label: { Text("Add") }).disabled($coffee.value.count == 0)
    }
}

#if DEBUG
struct NewTastingSheetView_Previews: PreviewProvider {
    static var previews: some View {
        NewTastingSheetView().environment(\.locale, Locale(identifier: "fr"))
    }
}
#endif
