//
//  RootView.swift
//  Gifts
//
//  Created by Александра Згонникова on 08.09.2025.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSigninView: Bool = false
    
    var body: some View {
        ZStack {
            if !showSigninView {
                BottomNavigationBar(showSignInView: $showSigninView)
            }
        }
        .onAppear {
            let authUser = try? AuthManager.shared.getAuthUser()
            self.showSigninView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSigninView, content: {
            NavigationStack {
                AuthView(showSignInView: $showSigninView)
            }
        })
    }
}

#Preview {
    RootView()
}
