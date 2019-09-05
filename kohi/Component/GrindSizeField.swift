import SwiftUI

struct GrindSizeField: View {
    let editMode : EditMode
    let grindMeasure : GrindMeasure
    @Binding var grindSize : Int
    
    var body: some View {
        Group {
            if (editMode == .active && grindMeasure == .texture) {
                texturePicker
            } else if (editMode == .active && grindMeasure == .metric) {
                sizeStepper
            } else if (editMode == .inactive && grindMeasure == .texture) {
                VStack(alignment: .leading) {
                    Text("Texture").foregroundColor(.secondary).font(.subheadline)
                    Text(GrindTexture.fromSize(size: self.grindSize).label.capitalized)
                }
            } else if (editMode == .inactive && grindMeasure == .metric) {
                VStack(alignment: .leading) {
                    Text("Size").foregroundColor(.secondary).font(.subheadline)
                    Text("\(self.grindSize)")
                }
            }
        }
    }
    
    var texturePicker: some View {
        Picker("Texture", selection: $grindSize) {
            ForEach(GrindTexture.allCases) { texture in
                Text(texture.label.capitalized).tag(texture.size)
            }
        }
    }
    
    var textureSelectableList: some View {
        Section(header: Text("TEXTURE")) {
            List {
                Group {
                    ForEach(GrindTexture.allCases) { texture in
                        HStack {
                            Text(texture.label.capitalized)
                            Spacer()
                            if (texture.id == GrindTexture.fromSize(size: self.grindSize).id) {
                                Image(systemName: "checkmark").foregroundColor(.blue)
                            }
                        }.onTapGesture {
                            self.grindSize = texture.size
                        }
                    }
                }
            }
        }
    }
    
    var sizeStepper: some View {
        Stepper(value: $grindSize, in: 0...100) {
            HStack {
                Text("Grind")
                Spacer()
                Text("\(grindSize)")
            }
        }
    }
}


struct GrindSizeField_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GrindSizeField(editMode: .active, grindMeasure: .texture, grindSize: .constant(12)).previewLayout(.sizeThatFits)
            GrindSizeField(editMode: .active, grindMeasure: .metric, grindSize: .constant(22)).previewLayout(.sizeThatFits)
            GrindSizeField(editMode: .inactive, grindMeasure: .texture, grindSize: .constant(55)).previewLayout(.sizeThatFits)
            GrindSizeField(editMode: .inactive, grindMeasure: .metric, grindSize: .constant(86)).previewLayout(.sizeThatFits)
        }
    }
}
