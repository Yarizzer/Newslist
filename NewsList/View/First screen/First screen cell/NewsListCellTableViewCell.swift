//
//  NewsListCellTableViewCell.swift
//  NewsList
//
//  Created by Yarr!zzeR on 29/01/2019.
//  Copyright © 2019 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class NewsListCellTableViewCell: UITableViewCell {

    var viewModel: NewsListCellViewModelType?
    
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleSource: UILabel!
    @IBOutlet weak var articlePublished: UILabel!
    @IBOutlet weak var watchedLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell() {
        guard let model = viewModel else { return }
        self.articleTitle.text = model.articleTitle
        self.articlePublished.text = model.articlePublished
        self.articleSource.text = model.articleSource
        self.watchedLabel.isHidden = !model.articleWatched
        activityIndicator.startAnimating()
        model.articleImage.bind { [unowned self] in
            guard let image = $0 else { return }
            self.articleImage.image = image
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
        
    }

}
