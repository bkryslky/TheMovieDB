//
//  SearchWireframe.swift
//  TheMovieDB
//
//  Created by Bekir Yeşilkaya on 15.04.2021.
//

import UIKit

class SearchWireframe: SearchPresenterToWireFrame {
    
    private let endpoint:Endpoint
    
    init(endpoint:Endpoint) {
        self.endpoint = endpoint
    }
    
    
    func builder() -> UIViewController {
        let view = SearchViewController.loadFromNib()
        var presenter : SearchViewToPresenter & SearchInteractorToPresenter = SearchPresenter()
        var interactor: SearchPresenterToInteractor = SearchInteractor(endpoint: endpoint)
        let router: SearchPresenterToWireFrame = SearchWireframe(endpoint: endpoint)
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        interactor.presenter = presenter
        return view
    }
    
    
    func goToDetail(from view:SearchPresenterToView,movie:Movie){
        let detailWireframe = DetailWireframe(endpoint: endpoint)
        let vc = detailWireframe.builder() as! DetailViewController
        vc.movie = movie
        (view as? UIViewController)?.present(vc, animated:false)
    }
    
    
}
