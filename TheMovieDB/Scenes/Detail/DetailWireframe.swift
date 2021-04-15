//
//  DetailWireframe.swift
//  TheMovieDB
//
//  Created by Bekir Yeşilkaya on 15.04.2021.
//

import UIKit

class DetailWireframe: DetailPresenterToWireframe {
  
    private let endpoint:Endpoint
    
    init(endpoint:Endpoint) {
        self.endpoint = endpoint
    }
    
    
    func builder() -> UIViewController {
        let view = DetailViewController.loadFromNib()
        var presenter : DetailViewToPresenter & DetailInteractorToPresenter = DetailPresenter()
        var interactor: DetailPresenterToInteractor = DetailInteractor(endpoint: endpoint)
        let router: DetailPresenterToWireframe = DetailWireframe(endpoint: endpoint)
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        interactor.presenter = presenter
        view.modalPresentationStyle = .fullScreen
        return view
    }
    
    func goToDetail(from view:DetailPresenterToView, movie: Movie) {
        let detailWireframe = DetailWireframe(endpoint: endpoint)
        let vc = detailWireframe.builder() as! DetailViewController
        vc.movie = movie
        (view as? UIViewController)?.present(vc, animated:false)
    }
    
}
