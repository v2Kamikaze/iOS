//
//  CatImagesManager.swift
//  CatFacts
//
//

import Foundation



class CatImagesManager {
    
    static let baseURL = "https://aws.random.cat/meow"
    
    static let shared = CatImagesManager()
    
    private init() {}
    
    func getFacts(completion: @escaping (Result<CatImageModel, CatFactsError>) -> Void) {
        // Setup the url
        guard let url = URL(string: CatImagesManager.baseURL) else {
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
                let dataDecoded = try decoder.decode(CatImageModel.self, from: data)
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
