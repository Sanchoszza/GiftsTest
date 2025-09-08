//
//  AuthView.swift
//  Gifts
//
//  Created by Александра Згонникова on 08.09.2025.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct AuthView: View {
    @StateObject private var viewModel = AuthViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        authFlow
    }
}

extension AuthView {
    private var authFlow: some View {
        VStack(alignment: .leading) {
            Text(NSLocalizedString("welcome", comment: ""))
                .font(.custom("SF Pro", size: 28))
                .fontWeight(.bold)
                .foregroundStyle(Color.theme.colorTextTitle)
                .padding(.bottom)
                .padding(.horizontal)
            
            Text(NSLocalizedString("welcomePromt", comment: ""))
                .font(.custom("SF Pro", size: 14))
                .fontWeight(.regular)
                .foregroundStyle(Color.theme.secondaryText)
                .padding(.horizontal)
//            Spacer()
            ZStack {
                Image("authCircle")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                
                Image("authFlower")
                    .padding(.bottom, 120)
                
                VStack {
                    Spacer()
                    
                    Button(action: {
                        Task {
                            do {
                                try await viewModel.signInApple()
                                showSignInView = false
                            } catch {
                                print(error)
                            }
                        }
                    }, label: {
                        SignInWithAppleButtonRepresentable(type: .continue, style: .white)
                            .allowsTightening(false)
                    })
                    .frame(height: 55)
                    
                    Button(action: {
                        Task {
                            do {
                                try await viewModel.signInGoogle()
                                showSignInView = false
                            } catch {
                                print(error)
                            }
                        }
                    }) {
                        HStack {
                            Image("googleIcon")
                                .resizable()
                                .frame(width: 20, height: 20)

                            Text("Continue with Google")
                                .font(.custom("SF Pro", size: 17))
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity, minHeight: 56)
                        .background(Color.theme.colorWhite)
                        .foregroundStyle(Color.theme.colorBlack)
                        .cornerRadius(12)
                    }

                    
                    VStack(alignment: .center) {
                        Text(NSLocalizedString("agreeText", comment: ""))
                            .font(.custom("SF Pro", size: 11))
                            .fontWeight(.regular)
                            .foregroundStyle(Color.theme.colorText)
                        HStack {
                            Text(NSLocalizedString("termsOfUse", comment: ""))
                                .font(.custom("SF Pro", size: 11))
                                .fontWeight(.regular)
                                .foregroundStyle(Color.theme.colorBlue)
                                .underline(true, color: Color.theme.colorBlue)

                            Text(NSLocalizedString("and", comment: ""))
                                .font(.custom("SF Pro", size: 11))
                                .fontWeight(.regular)
                                .foregroundStyle(Color.theme.colorText)
                            Text(NSLocalizedString("privacyPolicy", comment: ""))
                                .font(.custom("SF Pro", size: 11))
                                .fontWeight(.regular)
                                .foregroundStyle(Color.theme.colorBlue)
                                .underline(true, color: Color.theme.colorBlue)

                        }
                    }
                    .padding(.top, 16)
                }
                .padding(.bottom, 80)
                .padding(.horizontal)
            }
     
        }
        .frame(maxWidth: .infinity)
        .background(Color.theme.background)
        .toolbar {
            
            ToolbarItem(placement: .topBarTrailing) {
                Text(NSLocalizedString("skip", comment: ""))
                    .font(.custom("Open Sans", size: 18))
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.colorTextTitle)
            }
        }
    }
}
