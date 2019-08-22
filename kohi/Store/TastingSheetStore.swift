import Foundation
import Firebase


final class TastingSheetsStore: ObservableObject {
    let userId : String
    @Published var tastingSheets : [TastingSheet]
    let collection = Firestore.firestore().collection("tastingSheets")
    
    init(userId : String, tastingSheets : [TastingSheet] = [TastingSheet]()) {
        self.userId = userId
        self.tastingSheets = tastingSheets
    }
    
    func fetchAndListen() {
        collection.whereField("userId", isEqualTo: userId).addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                Crashlytics.sharedInstance().recordError("Error fetching snapshots: \(error!)")
                return
            }
            snapshot.documentChanges.forEach { diff in
                if (diff.type == .added) {
                    let data = TastingSheet(
                        id: diff.document.documentID,
                        method: Method(rawValue: diff.document.data()["method"] as? String ?? "") ??  Method.moka,
                        coffee: diff.document.data()["coffee"] as! String,
                        coffeeGrindSize: diff.document.data()["coffeeGrindSize"] as? Int,
                        coffeeWeightInGrams: diff.document.data()["coffeeWeightInGrams"] as? Int,
                        coffeeInfusionTimeInSeconds: diff.document.data()["coffeeInfusionTimeInSeconds"] as? Int,
                        waterQuantityInMilliliters: diff.document.data()["waterQuantityInMilliliters"] as? Int,
                        waterTemperatureInCelsius: diff.document.data()["waterTemperatureInCelsius"] as? Int,
                        tasteRatingOutOf5: diff.document.data()["tasteRatingOutOf5"] as? Int)
                    self.tastingSheets.append(data)
                }
                if (diff.type == .modified) {
                    let data = TastingSheet(
                        id: diff.document.documentID,
                        method: Method(rawValue: diff.document.data()["method"] as? String ?? "") ??  Method.moka,
                        coffee: diff.document.data()["coffee"] as! String,
                        coffeeGrindSize: diff.document.data()["coffeeGrindSize"] as? Int,
                        coffeeWeightInGrams: diff.document.data()["coffeeWeightInGrams"] as? Int,
                        coffeeInfusionTimeInSeconds: diff.document.data()["coffeeInfusionTimeInSeconds"] as? Int,
                        waterQuantityInMilliliters: diff.document.data()["waterQuantityInMilliliters"] as? Int,
                        waterTemperatureInCelsius: diff.document.data()["waterTemperatureInCelsius"] as? Int,
                        tasteRatingOutOf5: diff.document.data()["tasteRatingOutOf5"] as? Int)
                    self.tastingSheets.removeAll(where: { $0.id == diff.document.documentID })
                    self.tastingSheets.append(data)
                }
                if (diff.type == .removed) {
                    self.tastingSheets.removeAll(where: { $0.id == diff.document.documentID })
                }
            }
        }
    }
    
    func add(method: String, coffee: String, coffeeGrindSize: Int?, weight: Int?) {
        var data  =  ["method": method, "coffee": coffee, "userId": userId] as [String : Any]
        if(coffeeGrindSize != nil) {data["coffeeGrindSize"] =  coffeeGrindSize}
        if(weight != nil) {data["coffeeWeightInGrams"] =  weight}
        collection.addDocument(data: data)
    }
    
    func update(id: String, method: String, coffee: String, coffeeGrindSize: Int?, weight: Int?) {
        collection.document(id).updateData([
            "method": method,
            "coffee": coffee,
            "userId": userId,
            "coffeeGrindSize": coffeeGrindSize  ?? FieldValue.delete(),
            "coffeeWeightInGrams": weight  ?? FieldValue.delete()
        ])
    }
    
    
    func delete(id: String) {
        collection.document(id).delete() { err in
            if let err = err {
                Crashlytics.sharedInstance().recordError("Error removing document: \(err)")
            }
        }
    }
}



