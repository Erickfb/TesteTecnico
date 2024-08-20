//
//  DigioStoreService.swift
//  DigioStore
//
//  Created by Erick Fernandes Batista on 17/08/24.
//

import Foundation

class DigioStoreService {
    private let urlString = "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/sandbox/products"
    
    func fetchStoreData(completion: @escaping (Result<DigioStore, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let storeData = try JSONDecoder().decode(DigioStore.self, from: data)
                completion(.success(storeData))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
