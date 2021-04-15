//
//  DetailViewController.swift
//  TheMovieDB
//
//  Created by Bekir Yeşilkaya on 15.04.2021.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDetailLabel: UILabel!
    @IBOutlet weak var movieDateLabel: UILabel!
    @IBOutlet weak var movieRateLabel: UILabel!
    @IBOutlet weak var similarCollectionView: UICollectionView!
    
    //MARK: Variables
    private let star = "⭐️"
    var presenter:DetailViewToPresenter?
    var movie:Movie!
    private var similarMovies = [Movie]()
    
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        presenter?.startGettingDetails(movieId:movie.id) 
    }
    
    //MARK: Actions
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated:true)
    }
    
    //MARK: -SETUP COMPONENTS-
    private func setupViewDetail(detail:MovieDetail){
        if let imageUrlString =  detail.posterPath{
           let imageURL = URL(string: Constants.API.ImageBaseURL + imageUrlString)
            movieImageView.kf.setImage(with: imageURL)
        }
        movieTitleLabel.text = detail.title
        movieDetailLabel.text = detail.overview
        movieDateLabel.text = detail.releaseDate?.appDateFormatted().0
        movieRateLabel.text = "\(star) \(detail.voteAverage ?? 0.0)"
    }
    
    private func setupCollectionView(){
        
        similarCollectionView.register(type: SimilarCollectionViewCell.self)
        similarCollectionView.dataSource = self
        similarCollectionView.delegate = self
        
        let w:CGFloat = 96.0
        let h:CGFloat = 128.0
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: w, height: h)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.sectionInset = .zero
        
        similarCollectionView.collectionViewLayout = layout
        
    }
    

}


                    //MARK: -EXTENSIONS-

extension DetailViewController:DetailPresenterToView{
   
    
    func displaySimilarMovies(movies: [Movie]) {
        self.similarMovies = movies
        self.similarCollectionView.reloadData()
    }
    
    func displayMovieDetail(detail: MovieDetail) {
        self.setupViewDetail(detail: detail)
    }
    
    func displayLoading(status: Bool) {
        self.loading(status: status)
    }
    
    func displayError(error: APIError) {
        print(error.localizedDescription)
    }
}

extension DetailViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.similarMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ofType:SimilarCollectionViewCell.self, at: indexPath)
        cell.configureCell(model: self.similarMovies[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter?.router?.goToDetail(from: self, movie:self.similarMovies[indexPath.row])
    }
}
