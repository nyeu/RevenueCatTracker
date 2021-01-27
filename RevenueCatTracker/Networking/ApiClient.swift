//
//  apiClient.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 24/1/21.
//

import Foundation

enum Result<T: Codable & Equatable>: Equatable {
  case success(T)
  case error(String?)
}

protocol RevenueCatFetcher {
    func login(credentials: Credentials, completion: @escaping (Auth?) -> Void)
    func overview(sandboxMode: Bool, completion: @escaping (Overview?) -> Void)
    func transactions(sandboxMode: Bool, startFrom: String?, completion: @escaping (TransactionResult?) -> Void)
    func subscriber(sandboxMode: Bool, appId: String, subscriberId: String, completion: @escaping (SubscriberResponse?) -> Void)
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
    
    func apps(completion: @escaping (AppsResponse?) -> Void) {
        let url = "\(baseUrl)/me"
        let urlComponents = URLComponents(string: url)
        guard let validURL = urlComponents?.url else { return completion(nil) }
        fetch(url: validURL, completion: completion)
    }
    
    func overview(sandboxMode: Bool, completion: @escaping (Overview?) -> Void) {
        let url = "\(baseUrl)/me/overview"
        var urlComponents = URLComponents(string: url)
        urlComponents?.queryItems = [
            URLQueryItem(name: "sandbox_mode", value: sandboxMode ? "true" : "false")
        ]
        
        guard let validURL = urlComponents?.url else { return completion(nil) }
        
        fetch(url: validURL, completion: completion)
    }
    
    func transactions(sandboxMode: Bool, startFrom: String? = nil, completion: @escaping (TransactionResult?) -> Void) {
        let url = "\(baseUrl)/me/transactions"
        var urlComponents = URLComponents(string: url)
        
        urlComponents?.queryItems = {
            guard let startFrom = startFrom else {
                return [URLQueryItem(name: "sandbox_mode", value: sandboxMode ? "true" : "false")]
            }
            return [URLQueryItem(name: "sandbox_mode", value: sandboxMode ? "true" : "false"),
                    URLQueryItem(name: "start_from", value: startFrom)]
        }()
        
        guard let validURL = urlComponents?.url else { return completion(nil) }
        fetch(url: validURL, completion: completion)
    }
    
    func subscriber(sandboxMode: Bool, appId: String, subscriberId: String, completion: @escaping (SubscriberResponse?) -> Void) {
        let url = "\(baseUrl)/me/apps/\(appId)/subscribers/\(subscriberId)"
        let urlComponents = URLComponents(string: url)
        guard let validURL = urlComponents?.url else { return completion(nil) }
        fetch(url: validURL, completion: completion)
    }

    func fetch<T: Codable>(url: URL, completion: @escaping (T?) -> Void) {
        var request = urlRequestWithBasicHeaders(url: url)
        request.httpMethod = "GET"
                
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let data = data,
                let obj = try? JSONDecoder().decode(T.self, from: data)
            else {
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 403 {
                    mainStore.dispatch(MainStateAction.auth(Result.error("Token expired")))
                }
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
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 403 {
                    mainStore.dispatch(MainStateAction.auth(Result.error("Token expired")))
                }
                return completion(nil)
            }

            completion(obj)
        }
        task.resume()
    }
}


