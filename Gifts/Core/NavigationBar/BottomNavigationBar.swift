//
//  BottomNavigationBar.swift
//  Gifts
//
//  Created by Александра Згонникова on 08.09.2025.
//

import SwiftUI

struct BottomNavigationBar: View {
    @StateObject private var viewModel = AuthViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        TabView {
            NavigationStack {
                GiftView()
            }
            .tabItem {
                Image("gifts")
                Text(NSLocalizedString("gifts", comment: ""))
            }
            
            NavigationStack {
                Text("FLOWERS")
            }
            .tabItem {
                Image("flower")
                Text(NSLocalizedString("gifts", comment: ""))
            }
            
            NavigationStack {
                Text("EVENTS")
            }
            .tabItem {
                Image("events")
                Text(NSLocalizedString("events", comment: ""))
            }
            
            NavigationStack {
                Text("CART")
            }
            .tabItem {
                Image("cart")
                Text(NSLocalizedString("cart", comment: ""))
            }
            
            NavigationStack {
                VStack {
                    Text("PROFILE")

                    Button(action: {
                        Task {
                            do {
                                try viewModel.logOut()
                                showSignInView = true
                            } catch {
                                print("ERROR \(error)")
                            }
                        }
                    }, label: {
                        Text(NSLocalizedString("logOut", comment: ""))
                            .font(.custom("Open Sans", size: 14))
                            .fontWeight(.medium)
                            .foregroundStyle(Color.theme.colorTextTitle)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(Color.theme.colorWhite)
                            )
                            .overlay(content: {
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color.theme.borderColor)
                            })
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                            .padding(.top)
                    })
                    
                    Spacer()
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
                .background(Color.theme.background)
                
                
            }
            .tabItem {
                Image("profile")
                Text(NSLocalizedString("profile", comment: ""))
            }
        }
        .accentColor(Color.theme.colorTextTitle)
    }
}

