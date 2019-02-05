//
//  Services.swift
//  Loodos_Project
//
//  Created by Ünal Öztürk on 4.02.2019.
//  Copyright © 2019 Ünal Öztürk. All rights reserved.
//

import Foundation
import Alamofire

var omdbapiKey = "46245c79"

struct api {
    static let baseUrl = "http://omdbapi.com/"
}

enum MovieNotFound : Error {
    case movieNotFound
}

struct Service {
    
    static let sharedInstance = Service()
    
    func searchMovie(name: String, completion :  @escaping ([Movie]?,Error?)->()) {
        
        //Show Hud
        CustomLoader.instance.showLoader()
        
        let urlString = "\(api.baseUrl)?t=\(name)&apikey=\(omdbapiKey)"
        guard let url = URL(string: urlString ) else { fatalError("Search movie URL is not created.") }
        
        Alamofire.request(url).validate().responseJSON { response in
            //Dismiss Hud
            CustomLoader.instance.hideLoader()
            
            switch response.result {
                case .success:
                    guard let data = response.data else { return }
                    if (response.result.value as? [[String: Any]]) != nil  {
                        let movie = try? JSONDecoder().decode([Movie].self, from: data)
                        completion(movie,nil)
                    } else if let jSON = response.result.value as? [String : Any ] {
                        if jSON["Error"] != nil  {
                            completion(nil,MovieNotFound.movieNotFound)
                        } else {
                            let movie = try? JSONDecoder().decode(Movie.self, from: data)
                            completion([movie!],nil)
                        }
                        
                    }
                case .failure(let error):
                   completion(nil,error)
            }
        }
    }
}
