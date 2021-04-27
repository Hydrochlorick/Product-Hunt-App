//
//  NetworkManager.swift
//  ProductHuntPractice
//
//  Created by Rick Jacobson on 4/27/21.
//

import Foundation

class NetworkManager {
    let urlSession = URLSession.shared
    
    var baseURL = "https://api.producthunt.com/v1/"
    var token = "FoVaXoIqZfo8Bauyr7AikpfplMy5t6yWHB64NxelM9Q"
    
    func getPosts(completion: @escaping([Post]) -> Void) {
        let query = "posts/all?sort_by=votes_count&order=desc&search[featured]=true&per_page=20"
        let fullURL = URL(string: baseURL + query)!
        
        var request = URLRequest(url: fullURL)
        request.httpMethod = "GET"
        // Set up header with API Token
        request.allHTTPHeaderFields = [
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)",
            "Host": "api.producthunt.com"
        ]
        
        let task = urlSession.dataTask(with: request) { (data,response,error) in
            // Check for errors
            if let error = error {
                print(error.localizedDescription)
                return
            }
            // Check that data was retrieved
            guard let data = data else {
                return
            }
            
            // Attempt to decode data
            guard let result = try? JSONDecoder().decode(PostList.self, from: data) else {return}
            let posts = result.posts
            
            // Return the result with the completion handler
            DispatchQueue.main.async {
                completion(posts)
            }
        }
        task.resume()
    }
}
