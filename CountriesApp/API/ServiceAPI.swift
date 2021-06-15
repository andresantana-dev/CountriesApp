//
//  ServiceAPI.swift
//  CountriesApp
//
//  Created by André Santana on 09/06/2021.
//

import Foundation

enum ServiceError: Error, CustomNSError {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    var localizedDescription: String {
        switch self {
        case .apiError: return "failed_to_fetch_data".localized
        case .invalidEndpoint: return "invalid_endpoint".localized
        case .invalidResponse: return "invalid_response".localized
        case .noData: return "no_data".localized
        case .serializationError: return "failed_to_decode_data".localized
        }
    }
}

class ServiceAPI {
    
    // MARK: - Properties
    
    static let shared = ServiceAPI()
    
    private let apiKey = Private.apiKey
    private let apiURL = "https://restcountries-v1.p.rapidapi.com/all"
    private var dataTask: URLSessionDataTask?
    
    // MARK: - Methods
    
    func getCountries(completion: @escaping(Result<[Country], ServiceError>) -> Void) {
        guard let url = URL(string: apiURL) else {
            self.executeHandlerInMainThread(with: .failure(.invalidEndpoint), completion: completion)
            return
        }
        
        let headers = [
            "x-rapidapi-key": apiKey,
            "x-rapidapi-host": "restcountries-v1.p.rapidapi.com"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                self.executeHandlerInMainThread(with: .failure(.apiError), completion: completion)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.executeHandlerInMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }
            
            guard let data = data else {
                self.executeHandlerInMainThread(with: .failure(.noData), completion: completion)
                return
            }
            
            do {
                let countries = try JSONDecoder().decode([Country].self, from: data)
                self.executeHandlerInMainThread(with: .success(countries), completion: completion)
            } catch {
                self.executeHandlerInMainThread(with: .failure(.serializationError), completion: completion)
            }
        }
        dataTask?.resume()
    }
    
    private func executeHandlerInMainThread(with result: Result<[Country], ServiceError>, completion: @escaping(Result<[Country], ServiceError>) -> Void) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
