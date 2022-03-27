//
//  APIService.swift
//  BankDemo
//
//  Created by Santanu on 18/03/2022.
//

import Foundation
protocol APIServiceProtocol {
    func fetchTopStories( complete: @escaping ( _ success: Bool, _ topStories: [TopStorie], _ error: Error? )->() )
}
private enum Constant {
    static let quaryPath = "topstories/v2/home.json"
    static let baseUrlString = "https://api.nytimes.com/svc/"
    static let apiKey = "NOVRG34ooMNMdAj835jgPeMIyLk1n24E"
}
class UrlComponents {
    let path: String
   // let baseUrlString = "https://api.nytimes.com/svc/"
   // let apiKey = "NOVRG34ooMNMdAj835jgPeMIyLk1n24E"
    
    
    var url: URL {
        var query = [String]()
        query.append("api-key=\(Constant.apiKey)")
        
        guard let composedUrl = URL(string: "?" + query.joined(separator: "&"), relativeTo: NSURL(string: Constant.baseUrlString + path + "?") as URL?) else {
            fatalError("Unable to build request url")
        }
        
        return composedUrl
    }
    
    init(path: String) {
        self.path = path
    }
}

private let sessionManager: URLSession = {
    let urlSessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default
    return URLSession(configuration: urlSessionConfiguration, delegate: nil, delegateQueue: nil)
}()

class APIService: APIServiceProtocol {
  //  let quaryPath = "topstories/v2/home.json"
    // Simulate a long waiting for fetching
    func fetchTopStories( complete: @escaping ( _ success: Bool, _ results: [TopStorie], _ error: Error? )->() ) {
        
        let urlComponents = UrlComponents(path: Constant.quaryPath)
        let request = URLRequest(url: urlComponents.url)
        sessionManager.dataTask(with: request) { (data, response, error) in
            
            //Handle error case
            guard error == nil else {
                complete( false,[], error )

                return
            }
            guard let data = data else {
                return
            }
            let response = try? JSONDecoder().decode(TopStoriesResponse.self, from: data)
            if(response?.responseStatus == "OK") {
                if let resultsItem = response?.newsResults {
                    complete( true, resultsItem, nil )
                }
            } else{
                complete(false, [], error)
             }
            }.resume()

    }
    
    
    
}

