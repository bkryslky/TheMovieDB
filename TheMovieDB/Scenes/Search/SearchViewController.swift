//
//  SearchViewController.swift
//  TheMovieDB
//
//  Created by Bekir Yeşilkaya on 15.04.2021.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    var presenter:SearchViewToPresenter?
    private var searchMovies = [Movie]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
    }
    
    private func setupSearchBar(){
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
    }
    
    private func setupTableView(){
        searchTableView.register(type: SearchTableViewCell.self)
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.estimatedRowHeight = UITableView.automaticDimension
        searchTableView.rowHeight = 60.0
        
    }

}
extension SearchViewController:SearchPresenterToView{
    func displayMovies(movies: [Movie]) {
        self.searchMovies = movies
        self.searchTableView.reloadData()
    }

}

extension SearchViewController:UISearchBarDelegate{
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.startSearchMovies(search:searchText)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true)
    }
}

extension SearchViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: SearchTableViewCell.self, at: indexPath)
        cell.configureCell(model: self.searchMovies[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.router?.goToDetail(from:self, movie: searchMovies[indexPath.row])
    }
    
}
