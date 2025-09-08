//
//  AuthViewModel.swift
//  Gifts
//
//  Created by Александра Згонникова on 08.09.2025.
//

import Foundation

@MainActor
final class AuthViewModel: ObservableObject {
    
    private let apiManager = ClientManager()
    
    @Published var clientResponse: ClientResponse? = nil
    
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        let authDataResult = try await AuthManager.shared.signInWithGoogle(tokens: tokens)
        postClient { result in
            switch result {
            case .success:
                print("SUCCESS")
            case .failure(let error):
                print("ERROR \(error)")
            }
        }
    }
    
    func signInApple() async throws {
        let helper = SignInWithAppleHelper()
        let token = try await helper.startSignInWithAppleFlow()
        let authDataResult = try await AuthManager.shared.signInWithApple(tokens: token)
        postClient { result in
            switch result {
            case .success:
                print("SUCCESS")
            case .failure(let error):
                print("ERROR \(error)")
            }
        }
    }
    
    func postClient(completion: @escaping (Result<Void, Error>) -> Void) {
        let request = ClientRequest(
            jsonrpc: "2.0",
            method: "auth.firebaseLogin",
            params: ClientRequest.Params(fbIdToken: SPHelper.getIdToken()),
            id: 1)
        
        print("\(request)")
        
        apiManager.postClient(clientRequest: request) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let clientResponse):
                handleRegisterResponse(clientResponse)
                print("SUCCESS in postClient \(clientResponse)")
                completion(.success(()))
            case .failure(let error):
                print("Error in postClient \(error)")
                completion(.failure(error))
            }
        }
    }
    
    private func handleRegisterResponse(_ clientResponse: ClientResponse?) {
        guard let clientResponse = clientResponse else {
            print("No client received.")
            return
        }
        self.clientResponse = clientResponse
        print("handleResponse \(clientResponse)")
        SPHelper.setToken(clientResponse.result?.accessToken ?? "")
    }
    
    func logOut() throws {
        try AuthManager.shared.signOut()
    }
}
