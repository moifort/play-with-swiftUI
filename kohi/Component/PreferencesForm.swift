import SwiftUI

struct PreferencesForm: View {
    var logout : () -> Void = {}
    
    @Binding var grindMeasureId : String
    
    var body: some View {
        Form {
            
            Section(header: Text("GRIND MEASURE"),
                    footer: Text("Select metrics to have a 0 to 100 grind size or texture like coarse salt, caster sugar, etc.")) {
                List {
                    Group {
                        ForEach(GrindMeasure.allCases) { measure in
                            HStack {
                                Text(measure.label.capitalized).tag(measure.id)
                                Spacer()
                                Text("select")
                            }
                        }
                    }
                }
            }
            /* Section(footer: Text("Select metrics to have a 0 to 100 grind size or texture like coarse salt, caster sugar, etc.")) {
             Picker("Grind measure", selection: $grindMeasureId) {
             ForEach(GrindMeasure.allCases) { measure in
             Text(measure.label).tag(measure.id)
             }
             }
             }*/
            
            Button(action: { self.logout() }, label: {
                HStack(alignment: .center){
                    Spacer()
                    Text("Logout")
                    Spacer()
                }.foregroundColor(.red)
            })
        }
    }
}

struct PreferencesForm_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PreferencesForm(grindMeasureId: .constant("metrics"))
            PreferencesForm(grindMeasureId: .constant("metrics")).environment(\.colorScheme, .dark)
        }
    }
}
