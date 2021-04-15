//
//  SimilarCollectionViewCell.swift
//  TheMovieDB
//
//  Created by Bekir Yeşilkaya on 15.04.2021.
//

import UIKit

class SimilarCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}

extension SimilarCollectionViewCell:CellViewModelType{
    func configureCell(model: Movie) {
        if let imageUrlString =  model.posterPath{
           let imageURL = URL(string: Constants.API.ImageBaseURL + imageUrlString)
            imageView.kf.setImage(with: imageURL)
        }
        imageView.layer.cornerRadius = 10
        titleLabel.text = model.title
        if let year = model.releaseDate?.appDateFormatted().3{
            dateLabel.text = "(\(year))"
        }else{
            dateLabel.text = "()"
        }
        
    }
}
