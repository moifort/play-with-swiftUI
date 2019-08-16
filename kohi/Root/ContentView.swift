import SwiftUI


struct ContentView: View {
    @EnvironmentObject private var userSettingsStore: UserSettingsStore
    @EnvironmentObject private var userStore: UserStore
    
    var body : some View {
        VStack {
            if ($userSettingsStore.isLogged.value) {
                TastingSheetListView().environmentObject(TastingSheetsStore(userId: userSettingsStore.userId))
                        .environmentObject(self.userStore)
            }  else {
                LoginView(login: userStore.login)
            }
        }
        
    }
}
