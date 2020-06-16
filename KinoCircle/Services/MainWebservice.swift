//
//  Webservice.swift
//  KinoCircle
//
//  Created by Jan Madera on 10/05/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import Foundation

class MainWebservice {

    func getMovies(paramTitle: String, tag: String, completion: @escaping (ResponseList?) -> ()) {
            
        var myUrl = "https://movie-database-imdb-alternative.p.rapidapi.com/?r=json"
        
        let paramTitle = paramTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        let escapedParamTitle = paramTitle.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
                
        myUrl += "&type=" + tag
        myUrl += "&s=" + escapedParamTitle
                        
        guard let url = URL(string: myUrl) else { fatalError("Invalid API URL") }
        
        
        let headers = [
            "x-rapidapi-host": "movie-database-imdb-alternative.p.rapidapi.com",
            "x-rapidapi-key": "81396f7e72msh93fd244ecb58229p1af678jsn1a8c570d583f"
        ]
        
        let request = NSMutableURLRequest(url: url as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            
            
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            guard let myResponse = try? JSONDecoder().decode(ResponseList.self, from: data) else {
                fatalError("Invalid JSON")
            }
            
            
            DispatchQueue.main.async {
                completion(myResponse)
            }
        })
            .resume()
    }
    
    func getMovie(imdbID: String, completion: @escaping (MovieDetail?) -> ()) {
               
           var myUrl = "https://movie-database-imdb-alternative.p.rapidapi.com/?&r=json"
                        
           myUrl += "&i=" + imdbID
                                           
           guard let url = URL(string: myUrl) else { fatalError("Invalid API URL") }
           
           let headers = [
               "x-rapidapi-host": "movie-database-imdb-alternative.p.rapidapi.com",
               "x-rapidapi-key": "81396f7e72msh93fd244ecb58229p1af678jsn1a8c570d583f"
           ]
           
           let request = NSMutableURLRequest(url: url as URL,
                                             cachePolicy: .useProtocolCachePolicy,
                                             timeoutInterval: 10.0)
           request.httpMethod = "GET"
           request.allHTTPHeaderFields = headers
           
           
           URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
               
               
               guard let data = data, error == nil else {
                   DispatchQueue.main.async {
                       completion(nil)
                   }
                   return
               }
                                       
               guard let myResponse = try? JSONDecoder().decode(MovieDetail.self, from: data) else {
                   fatalError("Invalid JSON")
               }
               
               
               DispatchQueue.main.async {
                   completion(myResponse)
               }
           })
               .resume()
       }
}



