import Foundation
import Firebase


final class PreferenceStore: ObservableObject {
    var userId : String!
    @Published var preference = Preference()
    let collection = Firestore.firestore().collection("preferences")
    
    
    func fetch(userId : String) {
        self.userId = userId
        collection.document(userId).getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()!
                let grindMeasureId = data["grindMeasure"] as? String
                self.preference.grindMeasure = (grindMeasureId != nil) ? GrindMeasure.fromId(measureId: grindMeasureId!) : GrindMeasure.default
            } else {
                self.saveDefault(userId: userId)
            }
        }
    }
    
    func saveDefault(userId: String) {
        collection.document(userId).setData(["grindMeasure": GrindMeasure.default.id])
    }
    
    func update(grindMeasure: String) {
        collection.document(userId).updateData(["grindMeasure": grindMeasure])
    }
}



