//
//  ListInteractor.swift
//  TheMovieDB
//
//  Created by Bekir Yeşilkaya on 13.04.2021.
//

import Foundation

class ListInteractor:ListPresenterToInteractor{
    
    var presenter: ListInteractorToPresenter?
    private let endpoint:Endpoint
    private var nowPlayingCompleted = false
    private var upComingCompleted = false
    
    init(endpoint:Endpoint) {
        self.endpoint = endpoint
    }
    
    func getNowPlayings() {
        
        endpoint.getNowPlayings {[weak self] result in
            guard let self = self else {return}
            switch result{
            case .success(let base):
                if let movies = base.data{
                    self.presenter?.didGetNowPlayings(movies:movies)
                }
            case.failure(let error):
                self.presenter?.didGetError(error: error)
            }
            self.nowPlayingCompleted = true
            self.checkCompleted()
        }
      
    }
    
    func getUpComings() {
        
        endpoint.getUpComings {[weak self] result in
            guard let self = self else {return}
            switch result{
            case .success(let base):
                if let movies = base.data{
                    self.presenter?.didGetUpComings(movies:movies)
                }
            case.failure(let error):
                self.presenter?.didGetError(error: error)
            }
            self.upComingCompleted = true
            self.checkCompleted()
        }

    }
    
    private func checkCompleted(){
        if nowPlayingCompleted && upComingCompleted{
            presenter?.didCompleted()
        }
    }
    
}
