import Foundation

import Foundation

enum GrindTexture : CaseIterable, Identifiable {
    case coarsSalt, powderedSugar, fineSalt, flour
    
    var id: String {
        switch self {
        case .coarsSalt : return "coarse salt"
        case .powderedSugar : return "powdered sugar"
        case .fineSalt : return  "fine salt"
        case .flour : return "flour"
        }
    }
    
    var label: String {
       switch self {
        case .coarsSalt : return "coarse salt"
        case .powderedSugar : return "powdered sugar"
        case .fineSalt : return  "fine salt"
        case .flour : return "flour"
        }
    }
    
    static func fromId(textureId: String) -> GrindTexture {
        return self.allCases.filter({ $0.id == textureId}).first!
    }
    
    static let `default` = GrindTexture.powderedSugar
}
