//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by Rohan Gupta on 1/14/18.
//  Copyright © 2018 Rohan Gupta. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var refreshImage: UIActivityIndicatorView!
    
    var movies: [Movie] = []
    
    var refreshControl: UIRefreshControl!
    
    @IBOutlet var movieSearchBar: UISearchBar!
    
    var filteredMovies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshImage.startAnimating()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .
            valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.dataSource = self
        fetchMovies()
        
        

        // Do any additional setup after loading the view.
    }
    
    func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchMovies()
    }
    
    func fetchMovies() {
//        refreshImage.startAnimating()
        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                print("Success")
                print(movies)
            }
            else {
                print("Error")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        cell.movie = movies[indexPath.row]
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie as! [String : Any]
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //filter the movies array based on the user's search
//        let filtered = searchText.isEmpty ? movies : movies.filter({ (dataDictionary: NSDictionary) -> Bool in
//            let dataString = dataDictionary["title"] as! String
//            return dataString.lowercased().range(of: searchText.lowercased()) != nil
//        })
//
//        //assign the filtered array to filteredMovies
//        filteredMovies = filtered ?? []
        
        //reload data
        self.tableView.reloadData()
    }
    
    //function that shows the cancel button when the user is using the search bar
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        movieSearchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //remove the text and cancel button when the user clicks on the cancel button
        movieSearchBar.showsCancelButton = false
        movieSearchBar.text = ""
        
        //retract keyboard when the cancel button is clicked
        movieSearchBar.resignFirstResponder()
        
        //reload data with all of the movies array content
        filteredMovies = movies 
        self.tableView.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
