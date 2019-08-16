import Foundation
import SwiftUI
import Combine

final class UserSettingsStore: ObservableObject {
    private enum Keys {
        static let isLogged = "isLogged"
        static let userId = "userId"
    }
    
    private let cancellable: Cancellable
    private let defaults: UserDefaults
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        defaults.register(defaults: [Keys.isLogged: false,
                                     Keys.userId: ""])
        cancellable = NotificationCenter.default
            .publisher(for: UserDefaults.didChangeNotification)
            .map { _ in () }
            .subscribe(objectWillChange)
    }
    
    var isLogged: Bool {
        set { defaults.set(newValue, forKey: Keys.isLogged) }
        get { defaults.bool(forKey: Keys.isLogged) }
    }
    
    var userId: String {
        set { defaults.set(newValue, forKey: Keys.userId) }
        get { defaults.string(forKey: Keys.userId)! }
    }
}
