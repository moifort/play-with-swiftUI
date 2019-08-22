import Foundation
import Firebase
import PromiseKit
import AwaitKit
import AuthenticationServices

final class UserStore: ObservableObject {
    let collection = Firestore.firestore().collection("users")
    let credential = Credential()
    
    @Published var isLogged = UserDefaults.standard.bool(forKey: "isLogged")
    @Published var userId = UserDefaults.standard.string(forKey: "userId") ?? ""
    
    
    func logout() {
        UserDefaults.standard.set(false, forKey: "isLogged")
        self.isLogged = false
    }
    
    func login() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        self.credential.setSubscriber(subscriber: self.credential)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self.credential
        authorizationController.performRequests()
    }
    
    func credential(userCredential: UserCredential) {
        async {
            try! await(self.loginOrCreate(appleId: userCredential.userId,
                                          familyName: userCredential.familyName,
                                          givenName: userCredential.givenName,
                                          email: userCredential.email))
        }
    }
    
    
    func loginOrCreate(appleId: String, familyName: String, givenName: String, email: String) -> Promise<User> {
        async {
            if (appleId.isEmpty) {
                throw "No appleId"
            }
            let alreadySignUpUser = try! await(self.getUser(appleId))
            let user = alreadySignUpUser == nil
                ? try! await(self.signup(appleId: appleId, familyName: familyName, givenName: givenName, email: email))
                : alreadySignUpUser!
            
            DispatchQueue.main.sync {
                UserDefaults.standard.set(true, forKey: "isLogged")
                UserDefaults.standard.set(user.id, forKey: "userId")
                self.userId = user.id
                self.isLogged = true
                
            }
            
            return user
        }
    }
    
    func getUser(_ appleId: String) -> Promise<User?> {
        return Promise { seal in
            self.collection
                .whereField("appleId", isEqualTo: appleId)
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        seal.reject(err)
                    } else if querySnapshot!.documents.isEmpty {
                        seal.fulfill(nil)
                    } else {
                        let user = self.documentToUser(querySnapshot!.documents.first!)
                        seal.fulfill(user)
                    }
            }
        }
    }
    
    func signup(appleId: String, familyName: String, givenName: String, email: String) -> Promise<User> {
        return Promise { seal in
            var ref: DocumentReference? = nil
            ref = self.collection.addDocument(data: ["appleId": appleId, "familyName": familyName, "givenName": givenName, "email": email]) { err in
                if let err = err {
                    seal.reject(err)
                } else {
                    seal.fulfill(User(id: ref!.documentID, appleId: appleId,  givenName: givenName,familyName: familyName, email: email))
                }
            }
        }
    }
    
    func documentToUser(_ document: DocumentSnapshot) -> User {
        return User(id: document.documentID,
                    appleId: document.get("appleId") as? String ?? "",
                    givenName:  document.get("givenName") as? String ?? "",
                    familyName: document.get("familyName") as? String ?? "",
                    email: document.get("email") as? String ?? "")
    }
}

class Credential: NSObject, ASAuthorizationControllerDelegate{
    var subscriber : (UserCredential) -> (Void) = { userCredential in }
    
    func setSubscriber(subscriber : @escaping (UserCredential) -> (Void)) {
        self.subscriber = subscriber
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credentials = authorization.credential as? ASAuthorizationAppleIDCredential else {
            return
        }
        subscriber(UserCredential(userId: credentials.user,
                                  givenName: credentials.fullName?.givenName ?? "",
                                  familyName: credentials.fullName?.familyName ?? "",
                                  email: credentials.email ?? ""))
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    }
}

struct UserCredential {
    var userId : String
    var givenName: String
    var familyName: String
    var email: String
}

extension String: Error {}
