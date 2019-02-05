//
//  ViewController.swift
//  Loodos_Project
//
//  Created by Ünal Öztürk on 4.02.2019.
//  Copyright © 2019 Ünal Öztürk. All rights reserved.
//

import UIKit
import Alamofire


class MainViewController: UITableViewController , UISearchBarDelegate {
    
    let movieDataSource = MovieDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        
        movieDataSource.dataChanged = { [weak self] in
            self?.tableView.reloadData()
        }
        tableView.dataSource = movieDataSource
        createSearchBar()
      

    }
    
    func createSearchBar() {
        let search = UISearchBar()
        search.delegate = self
        search.placeholder = "Enter to search Movie"
        navigationItem.titleView = search
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let movieName = searchBar.text else { return }
        searchBar.endEditing(true)
        searchBar.text = ""
        
        //Search Movie
        movieName.count > 0 ? movieDataSource.fetch(movieName) : nil
        
    }
    
    //TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let moviesDetailViewController = MovieDetailViewController()
        moviesDetailViewController.movie =  movieDataSource.movies[indexPath.row]
        navigationController?.pushViewController(moviesDetailViewController, animated: true)
    }
    
    
}

