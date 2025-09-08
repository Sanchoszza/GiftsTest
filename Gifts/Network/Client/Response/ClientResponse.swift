//
//  ClientResponse.swift
//  Gifts
//
//  Created by Александра Згонникова on 08.09.2025.
//

import Foundation

struct ClientResponse: Codable {
    var jsonrpc: String?
    var result: Result?
    var id: Int?
    
    struct Result: Codable {
        var accessToken: String?
        var me: Me?
        
        struct Me: Codable {
            var id: Int?
            var name: String?
            
            init(from decoder: any Decoder) throws {
                let container: KeyedDecodingContainer<ClientResponse.Result.Me.CodingKeys> = try decoder.container(keyedBy: ClientResponse.Result.Me.CodingKeys.self)
                self.id = try container.decodeIfPresent(Int.self, forKey: ClientResponse.Result.Me.CodingKeys.id)
                self.name = try container.decodeIfPresent(String.self, forKey: ClientResponse.Result.Me.CodingKeys.name)
            }
            
            enum CodingKeys: String, CodingKey {
                case id = "id"
                case name = "name"
            }
            
            func encode(to encoder: any Encoder) throws {
                var container = encoder.container(keyedBy: ClientResponse.Result.Me.CodingKeys.self)
                try container.encodeIfPresent(self.id, forKey: ClientResponse.Result.Me.CodingKeys.id)
                try container.encodeIfPresent(self.name, forKey: ClientResponse.Result.Me.CodingKeys.name)
            }
        }
        
        init(from decoder: any Decoder) throws {
            let container: KeyedDecodingContainer<ClientResponse.Result.CodingKeys> = try decoder.container(keyedBy: ClientResponse.Result.CodingKeys.self)
            self.accessToken = try container.decodeIfPresent(String.self, forKey: ClientResponse.Result.CodingKeys.accessToken)
            self.me = try container.decodeIfPresent(ClientResponse.Result.Me.self, forKey: ClientResponse.Result.CodingKeys.me)
        }
        
        enum CodingKeys: String, CodingKey {
            case accessToken = "accessToken"
            case me = "me"
        }
        
        func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: ClientResponse.Result.CodingKeys.self)
            try container.encodeIfPresent(self.accessToken, forKey: ClientResponse.Result.CodingKeys.accessToken)
            try container.encodeIfPresent(self.me, forKey: ClientResponse.Result.CodingKeys.me)
        }
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.jsonrpc = try container.decodeIfPresent(String.self, forKey: .jsonrpc)
        self.result = try container.decodeIfPresent(ClientResponse.Result.self, forKey: .result)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
    }
    
    enum CodingKeys: String, CodingKey {
        case jsonrpc = "jsonrpc"
        case result = "result"
        case id = "id"
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.jsonrpc, forKey: .jsonrpc)
        try container.encodeIfPresent(self.result, forKey: .result)
        try container.encodeIfPresent(self.id, forKey: .id)
    }
}


struct ClientErrorResponse: Codable {
    let error: String?
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.error = try container.decodeIfPresent(String.self, forKey: .error)
    }
    
    enum CodingKeys: String, CodingKey {
        case error = "error"
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.error, forKey: .error)
    }
}
