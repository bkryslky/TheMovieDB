//
//  SearchInteractor.swift
//  TheMovieDB
//
//  Created by Bekir Yeşilkaya on 15.04.2021.
//

import Foundation

class SearchInteractor:SearchPresenterToInteractor{
    var presenter: SearchInteractorToPresenter?
    private let endpoint:Endpoint

    
    init(endpoint:Endpoint) {
        self.endpoint = endpoint
    }
    
    func searchMovies(search text: String) {
        endpoint.searchMovies(search: text) { result in
            switch result{
            case .success(let base):
                if let movies = base.data{
                    self.presenter?.didSearchMovies(movies: movies)
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
}
