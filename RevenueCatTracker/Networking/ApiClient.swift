//
//  apiClient.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 24/1/21.
//

import Foundation

enum Result<T: Codable & Equatable>: Equatable {
  case success(T)
  case error
}

protocol RevenueCatFetcher {
    func login(credentials: Credentials, completion: @escaping (Auth?) -> Void)
    func overview(completion: @escaping (Overview?) -> Void)
    func transactions(completion: @escaping (TransactionResult?) -> Void)
}

class ApiClient: RevenueCatFetcher {
    let baseUrl = "https://api.revenuecat.com/v1/developers"
    
    private func urlRequestWithBasicHeaders(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue("ios-client", forHTTPHeaderField: "X-Requested-With")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    func login(credentials: Credentials, completion: @escaping (Auth?) -> Void) {
        let json = [
            "email": credentials.email,
            "password": credentials.password
        ]
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        post(url: "\(baseUrl)/login", params: jsonData, completion: completion)
    }
    
    func overview(completion: @escaping (Overview?) -> Void) {
        let url = "\(baseUrl)/me/overview"
        fetch(url: url, completion: completion)
    }
    
    func transactions(completion: @escaping (TransactionResult?) -> Void) {
        let url = "\(baseUrl)/me/transactions"
        fetch(url: url, completion: completion)
    }

    func fetch<T: Codable>(url: String, completion: @escaping (T?) -> Void) {
        guard let url = URL(string: url) else { return completion(nil) }

        var request = urlRequestWithBasicHeaders(url: url)
        request.httpMethod = "GET"
                
        let task = URLSession.shared.dataTask(with: request) { data, _, _ in
            guard
                let data = data,
                let obj = try? JSONDecoder().decode(T.self, from: data)
            else {
                return completion(nil)
            }
            completion(obj)
        }

        task.resume()
    }
    
    func post<T: Codable>(url: String, params: Data?, completion: @escaping (T?) -> Void) {
        guard let url = URL(string: url) else { return completion(nil) }
        
        var request = urlRequestWithBasicHeaders(url: url)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.uploadTask(with: request, from: params) { data, response, error in
            guard
                let data = data,
                let obj = try? JSONDecoder().decode(T.self, from: data)
            else {
                return completion(nil)
            }

            completion(obj)
        }
        task.resume()
    }
}
