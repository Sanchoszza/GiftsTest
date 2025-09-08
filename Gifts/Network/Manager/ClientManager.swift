//
//  ClientManager.swift
//  Gifts
//
//  Created by Александра Згонникова on 08.09.2025.
//

import Foundation

class ClientManager: API {
    func postClient(clientRequest: ClientRequest, completion: @escaping (Result<ClientResponse, any Error>) -> Void) {
        guard let url = URL(string: "\(Const.test_url)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(clientRequest)
        
        print("URL \(url)")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response or no data"])))
                return
            }

            if let jsonString = String(data: data, encoding: .utf8) {
                print("Received JSON: \(jsonString)")
            }

            switch httpResponse.statusCode {
            case 200, 201:
                do {
                    let clientResponse = try JSONDecoder().decode(ClientResponse.self, from: data)
                    completion(.success(clientResponse))
                } catch let decodingError {
                    completion(.failure(decodingError))
                }
           
            default:
                do {
                    let errorResponse = try JSONDecoder().decode(ClientErrorResponse.self, from: data)
                    let error = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorResponse.error ?? "Unknown error occurred"])
                    completion(.failure(error))
                } catch let decodingError {
                    print("Decoding Error: \(decodingError)")
                    completion(.failure(decodingError))
                }
            }
        }.resume()
    }
}
