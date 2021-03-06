//
//  MovieListTableViewController.swift
//  Movie List
//
//  Created by Conner on 7/27/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController, MovieControllerProtocol, MovieTableViewCellDelegate {

    func seenButtonWasPressed(on cell: MovieTableViewCell) {
        guard let idx = tableView.indexPath(for: cell),
        let movieSeen = movieController?.movies[idx.row] else { return }
        movieController?.toggleSeenStatus(for: movieSeen)
        tableView.reloadRows(at: [idx], with: .fade)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieController?.movies.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
        guard let movieCell = cell as? MovieTableViewCell else { return cell }
        let movie = movieController?.movies[indexPath.row]
        
        movieCell.movie = movie
        movieCell.delegate = self
        
        return movieCell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let movie = movieController?.movies[indexPath.row] else { return }
            movieController?.delete(movie: movie)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Properties
    var movieController: MovieController?
}
