import Foundation

enum CoffeeMethod : CaseIterable, Identifiable {
    case moka, aeropress, siphon, v60, chemex, piston, espresso
    
    var id: String {
        switch self {
        case .moka : return "moka"
        case .aeropress : return "aeropress"
        case .siphon : return  "siphon"
        case .v60 : return "v60"
        case .chemex : return "chemex"
        case .piston : return "piston"
        case .espresso : return "espresso"
        }
    }
    
    var label: String {
        switch self {
        case .moka : return "moka".localized()
        case .aeropress : return "aeropress".localized()
        case .siphon : return  "siphon".localized()
        case .v60 : return "v60".localized()
        case .chemex : return "chemex".localized()
        case .piston : return "piston".localized()
        case .espresso : return "espresso".localized()
        }
    }
    
    var image: String {
        switch self {
        case .moka : return "moka"
        case .aeropress : return "aeropress"
        case .siphon : return  "siphon"
        case .v60 : return "v60"
        case .chemex : return "chemex"
        case .piston : return "piston"
        case .espresso : return "espresso"
        }
    }
    
    static func fromId(methodId: String) -> CoffeeMethod {
        return self.allCases.filter({ $0.id == methodId}).first!
    }
    
    static let `default` = CoffeeMethod.moka
}
