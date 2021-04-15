//
//  NowPlayingCollectionViewCell.swift
//  TheMovieDB
//
//  Created by Bekir Yeşilkaya on 15.04.2021.
//

import UIKit

class NowPlayingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
extension NowPlayingCollectionViewCell:CellViewModelType{
    func configureCell(model:Movie){
        if let imageUrlString =  model.posterPath{
           let imageURL = URL(string: Constants.API.ImageBaseURL + imageUrlString)
            imageView.kf.setImage(with: imageURL)
        }
        titleLabel.text = model.title
    }
}
