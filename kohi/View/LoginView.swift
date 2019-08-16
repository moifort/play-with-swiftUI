import SwiftUI
import PromiseKit
import AwaitKit
import AuthenticationServices

struct LoginView: View {
    var login: () -> Void = {}
    
    var body: some View {
        ZStack {
            Image("coffee")
                .resizable()
                .scaledToFill()
                .frame(height: 150)
                .blur(radius: 6)
            VStack {
                Spacer()
                Image("kohi")
                    .resizable()
                    .scaledToFit()
                    .padding(60)
                Spacer()
                SignInWithAppleButton()
                    .padding(.bottom, 15)
                    .onTapGesture { self.login() }
            }
        }
    }
}

#if DEBUG
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView().environment(\.locale, Locale(identifier: "fr")).previewDevice("iPhone Xr")
            LoginView().environment(\.locale, Locale(identifier: "en")).previewDevice("iPhone SE")
        }
    }
}
#endif
