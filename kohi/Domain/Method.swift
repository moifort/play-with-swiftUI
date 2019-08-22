import Foundation

enum Method: String, CaseIterable, Codable, Hashable {
    case moka = "moka"
    case aeropress = "aeropress"
    case siphon = "siphon"
    case v60 = "v60"
    case chemex = "chemex"
    case piston = "piston"
    case espresso = "espresso"
}
