//
//  Networking.swift
//  Licencjat
//
//  Created by Mikolaj Adamowicz on 16.04.2018.
//  Copyright © 2018 Mikolaj Adamowicz. All rights reserved.
//

//TODO: wrzucic numer albumu w header
//TODO: cachowac numer albumu
//TODO: logowanie zapytania do serwera o autoryzacje
//TODO: Sprawdzenie czy dana osoba juz odpowiedziala na pytanie czy nie w zaleznosci od numeru albumu
//TODO: wjebac Lottie gdzie sie da
//NOTE: OPIS WSZYTSKITEGO z punktu widzenia UI
/*
 
 1. otwiera sie table view
 2. api get wszystkie pytania
 3. cachuje pytania do structa ktory trzyma inne structy var pyatania = [Pytanie]
    3.1. po lewej tytul pytania z 3 kropakami jak jest za dlugi
    3.2. po prawej na gorze label Wynik:
    3.3. po prawej na dole label ktory jak nie ma wyniku to wyswietla date a jak jest to wyswietla 80% za lub 70% przeciw
    3.4. * Jesli sie da * to komorka jest wypelniona zielonym tyle i le bylo odpowiedzi za
 4. klikam pytanie przeniesinei do innego ekranu
 5. ekran z pytaniem taki jak jest teraz
 6. dane sa pobierane z zcachowanych pytan z tablicy
 7. po kliknieciu za albo przeciw
 8. ekran odpowiedziales za, odpowiedzialo tak 50 %
 9. lub odpowiedziales przeciw, odpowiedzialo tak 80 %
 10. ekran po wybraniu zostaje automatycznie wlaczony jak juz jest po wyznaczonej dacie
 */

//NOTE: OPIS WSZYTSKITEGO z punktu widzenia API
/*

 1. logowanie sprawdzam czy numer ma wystarczajaca ilosc numerkow i wysylam do serwera
 2. serwer przysyla czy jest ok czy nie: jesli tak to wysyla OK jesli nie to komunikat ma wartosc erroru
 3. zapisuje numeralbumu na dysk
 4. wpierdalam go do headera na kazde zapytanie
 4. jak pobieram pytania to wale get z numerem albumu
 5. serwer musi wyszukac w osobnej bazie moj numer i zobaczyc w indeksach na jakie pytania odpoweidzialem a na jakie nie limit pytan 60.
 6. czyli musze miec w bazie danych tabele:
 osoby= {
 id,
 ansered question= [questions]
 
 */

import Foundation
import Alamofire

enum Result<Value> {
    case success(Value)
    case failure(Error)
}

enum Status {
    case success()
    case failure(Error)
}

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
                        let questions = try decoder.decode([Question].self, from: jsonData)
                        completion?(.success(questions))
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
    
    func getNewestQuestion(completion: ((Result<[Question]>) -> Void)?) {
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
    func putAnswer(answer: Question, completion: ((Result<Any>) -> Void)?) {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = "/answer/"+answer.id
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
            completion?(.failure(error))
        }
        
        // Create and run a URLSession data task with our JSON encoded POST request
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                completion?(.failure(responseError!))
                return
            }
            
            
            // APIs usually respond with the data you just sent in your POST request
            if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
                print("response: ", utf8Representation)
                completion?(.success("ok"))
//                let decoder = JSONDecoder()
//
//                do {
//                    // We would use Post.self for JSON representing a single Post
//                    // object, and [Post].self for JSON representing an array of
//                    // Post objects
//                    let question = try decoder.decode(Question.self, from: data)
//                    completion?(.success(question))
//                } catch {
//                    completion?(.failure(error))
//                }

            } else {
                print("no readable data received in response")
            }
        }
        task.resume()
    }

}


