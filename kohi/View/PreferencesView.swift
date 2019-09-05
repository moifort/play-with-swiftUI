import SwiftUI

struct PreferencesView: View {
    var logout : () -> Void = {}
    var update: (String) -> Void = {_ in }
    @Environment(\.presentationMode) var presentationMode
    @State var isLogout = false
    @State var grindMeasureId = GrindMeasure.default.id
    
    func viewLogout() {
        self.isLogout = true
        self.presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        NavigationView {
            PreferencesForm(logout: self.viewLogout, grindMeasureId: $grindMeasureId)
                .navigationBarTitle(Text("Preferences"), displayMode: .inline)
                .navigationBarItems(leading: cancelButton, trailing: saveButton)
                .onDisappear() {
                    if (self.isLogout) {
                        self.logout()
                    }
            }
        }
    }
    
    var saveButton: some View {
        Button(action: {
            self.update(self.grindMeasureId)
            self.presentationMode.wrappedValue.dismiss()
        }, label: { Text("Save") })
    }
    
    var cancelButton: some View {
        Button(action: { self.presentationMode.wrappedValue.dismiss() },
               label: { Text("Cancel") })
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
