//
//  MovieTableCell.swift
//  BookMyShow
//
//  Created by Neeraj Solanki on 10/10/20.
//  Copyright © 2020 Mr.Solanki. All rights reserved.
//

import UIKit

class MovieTableCell: UITableViewCell {

    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    
    var movieID : Int64?
    var bookNowButtonAction : ((Int64?) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bookButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        moviePosterImageView.layer.cornerRadius = 10
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    } 
    
    func configureCell(viewModel:MovieCellViewModel){
        layoutIfNeeded()
        movieTitleLabel.text = viewModel.movieTitle
        releaseDateLabel.text = viewModel.releaseDate
        genreLabel.text = viewModel.genre
        moviePosterImageView.image = nil
        movieID = viewModel.movieID
        
        if !viewModel.movieImage.isEmpty {
            let urlString = "\(Constants.imageBaseURL)\(viewModel.movieImage)\(ApiKey.queryParamter)\(ApiKey.value)"
            moviePosterImageView?.loadImage(urlString: urlString)
            moviePosterImageView?.contentMode = .scaleAspectFill
        }
    }
    
    @IBAction func bookButtonAction(_ sender: UIButton) {
        bookNowButtonAction?(movieID)
    }
}
