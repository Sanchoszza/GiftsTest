//
//  GiftsApp.swift
//  Gifts
//
//  Created by Александра Згонникова on 08.09.2025.
//

import SwiftUI
import Firebase

@main
struct GiftsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        configureAppearance()
    }
    
    private func configureAppearance() {
        UITableView.appearance().backgroundColor = UIColor.clear
        UINavigationBar.appearance().tintColor = UIColor(Color.theme.colorTextTitle)
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(Color.theme.colorWhite)
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.theme.colorTextTitle)
        let attributes: [NSAttributedString.Key:Any] = [
            .foregroundColor : UIColor.white
        ]
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected)
        UITextView.appearance().backgroundColor = .clear
        UITextView.appearance().tintColor = UIColor(Color.theme.colorTextTitle)
        UIButton.appearance().isExclusiveTouch = true
        UIButton.appearance().isOpaque = true
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
