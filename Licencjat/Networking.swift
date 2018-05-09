//
//  Networking.swift
//  Licencjat
//
//  Created by Mikolaj Adamowicz on 16.04.2018.
//  Copyright © 2018 Mikolaj Adamowicz. All rights reserved.
//

import Foundation
import Alamofire

class Networking{
    let scheme = "http"
    let host = "localhost"
    let port = 3000
    
     func getQuestions(completion: ((Result<[Question]>) -> Void)?) {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = "/getSurveys"
        urlComponents.port = port
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                
                if let error = responseError {
                    completion?(.failure(error))
                } else if let jsonData = responseData {
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        // We would use Post.self for JSON representing a single Post
                        // object, and [Post].self for JSON representing an array of
                        // Post objects
                        let question = try decoder.decode([Question].self, from: jsonData)
                        completion?(.success(question))
                    } catch {
                        completion?(.failure(error))
                    }
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                    completion?(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    
    
    // We'll need a completion block that returns an error if we run into any problems
     func putAnswer(answer: Question, completion:((Error?) -> Void)?) {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = "/posts"
        urlComponents.port = port
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        
        // Specify this request as being a POST method
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        // Make sure that we include headers specifying that our request's HTTP body
        // will be JSON encoded
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        // Now let's encode out Post struct into JSON data...
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(answer)
            // ... and set our request's HTTP body
            request.httpBody = jsonData
            print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
        } catch {
            completion?(error)
        }
        
        // Create and run a URLSession data task with our JSON encoded POST request
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                completion?(responseError!)
                return
            }
            
            // APIs usually respond with the data you just sent in your POST request
            if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
                print("response: ", utf8Representation)
            } else {
                print("no readable data received in response")
            }
        }
        task.resume()
    }

}


