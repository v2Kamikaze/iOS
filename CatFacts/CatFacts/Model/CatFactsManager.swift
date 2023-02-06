//
//  CatFactAPIController.swift
//  CatFacts
//
//

import Foundation

enum CatFactsError: Error {
    case badURL, invalidJSON, noData, badResponse
}

class CatFactsManager {
    
    static let baseURL = "https://cat-fact.herokuapp.com/facts"
    
    static let shared = CatFactsManager()
    
    private init() {}
    
    func getFacts(completion: @escaping (Result<CatFactsModel, CatFactsError>) -> Void) {
        // Setup the url
        guard let url = URL(string: CatFactsManager.baseURL) else {
            completion(.failure(.badURL))
            return
        }
        
        // Create a configuration
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = true
        
        // Create a session
        let session = URLSession(configuration: configuration)
        
        // Create a task
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.invalidJSON))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.badResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let dataDecoded = try decoder.decode(CatFactsModel.self, from: data)
                completion(.success(dataDecoded))
                return
            } catch {
                completion(.failure(.invalidJSON))
                return
            }
            
        }
        
        task.resume()
    }
    
}
