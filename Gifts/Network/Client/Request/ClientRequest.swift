//
//  ClientRequest.swift
//  Gifts
//
//  Created by Александра Згонникова on 08.09.2025.
//

import Foundation

struct ClientRequest: Codable {
    var jsonrpc: String?
    var method: String?
    var params: Params?
    var id: Int?
    
    struct Params: Codable {
        var fbIdToken: String?
    }
}
