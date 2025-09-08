//
//  API.swift
//  Gifts
//
//  Created by Александра Згонникова on 08.09.2025.
//

import Foundation

protocol API {
    func postClient(clientRequest: ClientRequest, completion: @escaping (Result<ClientResponse, Error>) -> Void)
}
