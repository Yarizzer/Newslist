//
//  ReadlistTableViewCell.swift
//  NewsList
//
//  Created by Yarr!zzeR on 31/01/2019.
//  Copyright © 2019 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class ReadlistTableViewCell: UITableViewCell {

    var viewModel: ReadlistCellViewModelType?
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var appendMoment: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell() {
        guard let model = viewModel else { return }
        self.articleTitle.text = model.articleTitle
        self.appendMoment.text = model.appendMoment
        let image = model.articleImage ?? UIImage(named: "ImagePlaseholder")
        self.articleImage.image = image
    }

}
