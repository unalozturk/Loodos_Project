//
//  MovieDetailViewController.swift
//  Loodos_Project
//
//  Created by Ünal Öztürk on 4.02.2019.
//  Copyright © 2019 Ünal Öztürk. All rights reserved.
//

import UIKit
import Kingfisher
import Firebase

class MovieDetailViewController: UIViewController {
    
    var movie: Movie?
    var moviesDetailView = MoviesDetailView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        firebaseMovieDetailViewLog()
        fillView()
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        moviesDetailView.screenRotated()
       
    }
    
    func fillView() {
        
        if let url = URL(string: movie?.Poster ?? "") , let movieName = movie?.Title , let imdb = movie?.imdbRating {
            moviesDetailView.posterImage.kf.setImage(with: url)
            moviesDetailView.movieNameLbl.text = movieName
            self.title = "Imdb Rating: \(imdb)"
        }
        self.view = moviesDetailView
    }
    
    func firebaseMovieDetailViewLog() {
        if let movie = movie {
            
            Analytics.logEvent("view_item", parameters: [
                "name": movie.Title,
                "imdbRating" : movie.imdbRating,
                "writer" : movie.Writer
                ])
            
        } else {
            print("There is no movie to log.")
        }
        
    }

}
