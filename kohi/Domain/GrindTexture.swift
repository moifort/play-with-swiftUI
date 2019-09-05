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
        case .coarsSalt : return "coarse salt".localized()
        case .powderedSugar : return "powdered sugar".localized()
        case .fineSalt : return  "fine salt".localized()
        case .flour : return "flour".localized()
        }
    }
    
    var size: Int {
        switch self {
        case .coarsSalt : return 100
        case .powderedSugar : return 75
        case .fineSalt : return  50
        case .flour : return 25
        }
    }
    
    static func fromId(textureId: String) -> GrindTexture {
        return self.allCases.filter({ $0.id == textureId}).first!
    }
    
    static func fromSize(size: Int) -> GrindTexture {
        switch size {
        case 0 ... 25: return self.flour
        case 26 ... 50: return self.fineSalt
        case 51 ... 75: return self.powderedSugar
        case 76 ... 100: return self.coarsSalt
        default: return self.default
        }
    }
    
    static let `default` = GrindTexture.powderedSugar
}
