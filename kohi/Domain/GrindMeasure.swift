import Foundation

enum GrindMeasure : CaseIterable, Identifiable {
    case metric, texture
    
    var id: String {
        switch self {
        case .metric: return "metric"
        case .texture: return "texture"
        }
    }
    
    var label: String {
        switch self {
        case .metric: return "metric"
        case .texture: return "texture"
        }
    }
    
    static func fromId(measureId: String) -> GrindMeasure {
        return self.allCases.filter({ $0.id == measureId}).first!
    }
    
    static let `default` = GrindMeasure.texture
}

