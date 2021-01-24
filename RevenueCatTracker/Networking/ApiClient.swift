//
//  apiClient.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 24/1/21.
//

import Foundation

struct TMDBPagedResult<T: Codable>: Codable {
    let results: [T]
    let page: Int
    let totalPages: Int
    let totalResults: Int

    private enum CodingKeys: String, CodingKey {
        case results
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

protocol RevenueCatFetcher {
//    func fetchMovieGenres(completion: @escaping (GenreList?) -> Void)
//    func fetchUpcomingMovies(page: Int, completion: @escaping (TMDBPagedResult<Movie>?) -> Void)
//    func searchMovies(query: String, page: Int, completion: @escaping (TMDBPagedResult<Movie>?) -> Void)
    func login(credentials: Credentials, completion: @escaping (Auth?) -> Void)
}

class ApiClient: RevenueCatFetcher {
//    let apiKey = "1f54bd990f1cdfb230adb312546d765d"
    let baseUrl = "https://api.revenuecat.com/v1/developers"
    
    func login(credentials: Credentials, completion: @escaping (Auth?) -> Void) {
        let json = [
            "email": "joancardona.17@gmail.com",//credentials.email,
            "password": "*bGB9LF3Fke_Zu.d_F7mrgH39Yg!k6F@cuNjrmy8" //credentials.password
        ]
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])

        post(url: "\(baseUrl)/login", params: jsonData, completion: completion)
    }

    func fetch<T: Codable>(url: String, completion: @escaping (T?) -> Void) {
        guard let url = URL(string: url) else { return completion(nil) }

        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
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

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
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
