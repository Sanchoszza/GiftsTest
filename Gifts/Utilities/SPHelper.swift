//
//  SPHelper.swift
//  Gifts
//
//  Created by Александра Згонникова on 08.09.2025.
//

import Foundation

class SPHelper {
    static let ID_TOKEN = "id_token"
    static let ACCESS_TOKEN = "access_token"
    
    private static func getDefaults() -> UserDefaults{
        return UserDefaults.standard
    }
    
    static func setIdToken(_ token: String){
        getDefaults().set(token, forKey: ID_TOKEN)
    }
    
    static func getIdToken() -> String {
        return getDefaults().string(forKey: ID_TOKEN) ?? ""
    }
    
    static func setToken(_ token: String){
        getDefaults().set(token, forKey: ACCESS_TOKEN)
    }
    
    static func getToken() -> String {
        return getDefaults().string(forKey: ACCESS_TOKEN) ?? ""
    }
}
