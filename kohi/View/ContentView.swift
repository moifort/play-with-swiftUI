import SwiftUI


struct ContentView: View {
    @EnvironmentObject private var userStore: UserStore
    
    var body : some View {
        Group {
            if (userStore.isLogged && !userStore.userId.isEmpty) {
                TastingSheetListView().environmentObject(TastingSheetsStore(userId: userStore.userId))
            }  else {
                LoginView(login: userStore.login)
            }
        }
    }
}


