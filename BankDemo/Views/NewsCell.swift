//
//  NewsCell.swift
//  BankDemo
//
//  Created by Santanu on 18/03/2022.
//

import Foundation
import UIKit

class NewsCell: UITableViewCell {
    @IBOutlet weak var newCoverBy: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    func setupView(cellVM: TopStoriesListCellViewModel) {
        self.newsTitle.text = cellVM.titleText
        self.newCoverBy.text = cellVM.authorText
        self.newsImage.downloadImageFromURL(cellVM.imageUrl,icon: UIImage(named: "placeholder"))
    }
}
