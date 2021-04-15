//
//  SearchTableViewCell.swift
//  TheMovieDB
//
//  Created by Bekir Yeşilkaya on 15.04.2021.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var movieNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension SearchTableViewCell:CellViewModelType{
    func configureCell(model: Movie) {
        movieNameLabel.text = model.title
    }
}
