import SwiftUI
import AuthenticationServices

protocol CredentialData {
    func get(email: String)
}

struct SignInWithAppleButton: View {    
    var body: some View {
        AppleSignInButtonView().frame(height: 50, alignment: .center).padding(.all)
    }
}

struct AppleSignInButtonView: UIViewRepresentable {
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return  ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .black)
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: UIViewRepresentableContext<AppleSignInButtonView>) {}
}

#if DEBUG
struct SignInWithAppleButton_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithAppleButton().environment(\.locale, Locale(identifier: "fr"))
    }
}
#endif
