//
//  UpComingTableViewCell.swift
//  TheMovieDB
//
//  Created by Bekir Yeşilkaya on 15.04.2021.
//

import UIKit
import Kingfisher
class UpComingTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieDetailLabel: UILabel!
    @IBOutlet weak var movieDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
  
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}

extension UpComingTableViewCell:CellViewModelType{
    func configureCell(model:Movie){
        if let imageUrlString =  model.posterPath{
           let imageURL = URL(string: Constants.API.ImageBaseURL + imageUrlString)
            movieImageView.kf.setImage(with: imageURL)
        }
        movieImageView.layer.cornerRadius = 10
        movieNameLabel.text = model.title
        movieDetailLabel.text = model.overview
        movieDateLabel.text = model.releaseDate?.appDateFormatted().0
    }
}
