import SwiftUI

struct GrindSizeField: View {
    @EnvironmentObject private var preferenceStore: PreferenceStore
    @Binding var grindSize : Int
    
    
    var body: some View {
        Group {
            if (preferenceStore.preference.grindMeasure == .texture) {
                Picker("Texture", selection: $grindSize) {
                    ForEach(GrindTexture.allCases) { texture in
                        Text(texture.label).tag(texture.id)
                    }
                }
            }
            else {
                Stepper(value: $grindSize, in: 0...100) {
                    HStack {
                        Text("Grind")
                        Spacer()
                        Text("\(grindSize)")
                    }
                }
            }
        }
    }
}

struct GreindSizeField_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GrindSizeField(grindSize: .constant(12))
            GrindSizeField(grindSize: .constant(12))
        }
    }
}
