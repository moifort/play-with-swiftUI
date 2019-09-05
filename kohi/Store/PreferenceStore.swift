import Foundation
import Firebase


final class PreferenceStore: ObservableObject {
    var userId : String!
    @Published var preference = Preference()
    let collection = Firestore.firestore().collection("preferences")
    
    
    func fetchAndListen(userId: String) {
        self.userId = userId
        self.collection.document(userId).addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                Crashlytics.sharedInstance().recordError("Error fetching snapshots: \(error!)")
                return
            }
            if (snapshot.exists) {
                let data = snapshot.data()!
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



