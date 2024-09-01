//
//  TodoApi.swift
//  Orel_TodoApiFatch
//
//  Created by Anna Pinchuk on 01/09/2024.
//

import Foundation


class TodoApi {
    
    static let shared = TodoApi()
    static let apiTodosUrlString = "https://jsonplaceholder.typicode.com/todos"
    
    init(){}
    
    // Generic fetch function
    func fetchData<T: Decodable>(from urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            print("Invalid api address: \(urlString)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let data = data {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } else {
                    print("No data found at URL: \(urlString)")
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data found"])))
                }
            } catch {
                print("Error decoding data: \(error)")
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    // Example usage of the generic function for fetching todos
    func fetchTodos(completion: @escaping (Result<[Todo], Error>) -> Void) {
        fetchData(from: TodoApi.apiTodosUrlString, completion: completion)
    }
    
    // Example usage of the generic function for fetching todo details
    func fetchTodoDetails(apiAddress: String, completion: @escaping (Result<TodoDetails, Error>) -> Void) {
        fetchData(from: apiAddress, completion: completion)
    }
}
