//
//  HomeDataSource.swift
//  Loodos_Project
//
//  Created by Ünal Öztürk on 4.02.2019.
//  Copyright © 2019 Ünal Öztürk. All rights reserved.
//

import UIKit
import Alamofire

class MovieDataSource: NSObject, UITableViewDataSource {
    
    var reuseIdentifier = "Cell"
    var dataChanged: (() -> Void)?
    var movies = [Movie]()
    
    func fetch(_ movieName: String )   {
        Service.sharedInstance.searchMovie(name:movieName) { (moviesFromService, error) in
            if (error as? MovieNotFound) != nil {
                
                self.showAlerView(title: "Warning", message: "Movie not found!")
                
                self.movies = []
                self.dataChanged?()
                
            } else if let error = error {
                print("While Searching \(movieName), error occured: \(error)")
            } else  {
                self.movies = moviesFromService!
                self.dataChanged?()
            }
           
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,
                                   reuseIdentifier: reuseIdentifier)
        let item = movies[indexPath.row]
        cell.textLabel?.text = item.Title
        cell.detailTextLabel?.text = String("IMDb Rating: \(item.imdbRating)")
        
        return cell
    }

    
    func movie(at index: Int) -> Movie {
        return movies[index]
    }
    
    func showAlerView(title : String , message : String) {
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            rootVC.showAlertView(title: title, message: message)
        }
    }

}
