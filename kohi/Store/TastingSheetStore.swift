import Foundation
import Firebase


final class TastingSheetsStore: ObservableObject {
    var userId : String!
    @Published var tastingSheets = [TastingSheet]()
    let collection = Firestore.firestore().collection("tastingSheets")
    
    init(tastingSheets : [TastingSheet] = [TastingSheet]()) {
        self.tastingSheets = tastingSheets
    }
    
    func fetchAndListen(userId: String) {
        self.userId = userId
        collection.whereField("userId", isEqualTo: userId).addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                Crashlytics.sharedInstance().recordError("Error fetching snapshots: \(error!)")
                return
            }
            snapshot.documentChanges.forEach { diff in
                if (diff.type == .added) {
                    let data = self.toTastingSheet(
                        id: diff.document.documentID,
                        method: diff.document.data()["method"] as? String,
                        coffee: diff.document.data()["coffee"] as? String,
                        coffeeGrindSize: diff.document.data()["coffeeGrindSize"] as? Int,
                        coffeeWeightInGrams: diff.document.data()["coffeeWeightInGrams"] as? Int,
                        coffeeInfusionTimeInSeconds: diff.document.data()["coffeeInfusionTimeInSeconds"] as? Int,
                        waterQuantityInMilliliters: diff.document.data()["waterQuantityInMilliliters"] as? Int,
                        waterTemperatureInCelsius: diff.document.data()["waterTemperatureInCelsius"] as? Int,
                        tasteRatingOutOf5: diff.document.data()["tasteRatingOutOf5"] as? Int)
                    self.tastingSheets.append(data)
                }
                if (diff.type == .modified) {
                    let data = self.toTastingSheet(
                        id: diff.document.documentID,
                        method: diff.document.data()["method"] as? String,
                        coffee: diff.document.data()["coffee"] as? String,
                        coffeeGrindSize: diff.document.data()["coffeeGrindSize"] as? Int,
                        coffeeWeightInGrams: diff.document.data()["coffeeWeightInGrams"] as? Int,
                        coffeeInfusionTimeInSeconds: diff.document.data()["coffeeInfusionTimeInSeconds"] as? Int,
                        waterQuantityInMilliliters: diff.document.data()["waterQuantityInMilliliters"] as? Int,
                        waterTemperatureInCelsius: diff.document.data()["waterTemperatureInCelsius"] as? Int,
                        tasteRatingOutOf5: diff.document.data()["tasteRatingOutOf5"] as? Int)
                    let indexToReplace = self.tastingSheets.firstIndex(where: { $0.id == diff.document.documentID })!
                    self.tastingSheets[indexToReplace] = data
                }
                if (diff.type == .removed) {
                    self.tastingSheets.removeAll(where: { $0.id == diff.document.documentID })
                }
            }
        }
    }
    
    func add(method: String, coffee: String, coffeeGrindSize: Int?, weight: Int?) {
        var data  =  ["method": method, "coffee": coffee, "userId": userId!] as [String : Any]
        if(coffeeGrindSize != nil) {data["coffeeGrindSize"] =  coffeeGrindSize}
        if(weight != nil) {data["coffeeWeightInGrams"] =  weight}
        collection.addDocument(data: data)
    }
    
    func update(id: String, method: String, coffee: String, coffeeGrindSize: Int?, weight: Int?) {
        collection.document(id).updateData([
            "method": method,
            "coffee": coffee,
            "userId": userId!,
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
    
    func toTastingSheet(id: String,
                        method: String?,
                        coffee: String?,
                        coffeeGrindSize: Int?,
                        coffeeWeightInGrams: Int?,
                        coffeeInfusionTimeInSeconds: Int?,
                        waterQuantityInMilliliters: Int?,
                        waterTemperatureInCelsius: Int?,
                        tasteRatingOutOf5: Int?) -> TastingSheet
    {
        return TastingSheet(id: id,
                            method: method == nil ? CoffeeMethod.default : CoffeeMethod.fromId(methodId: method!),
                            coffee: coffee ?? "",
                            coffeeGrindSize: coffeeGrindSize,
                            coffeeWeightInGrams: coffeeWeightInGrams,
                            coffeeInfusionTimeInSeconds: coffeeInfusionTimeInSeconds,
                            waterQuantityInMilliliters: waterQuantityInMilliliters,
                            waterTemperatureInCelsius: waterTemperatureInCelsius,
                            tasteRatingOutOf5: tasteRatingOutOf5)
    }
    
}



