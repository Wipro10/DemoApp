//
//  NewsCell.swift
//  BankDemo
//
//  Created by Santanu on 18/03/2022.
//

import Foundation
import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak private var newsCoverBy: UILabel!
    
    @IBOutlet weak private var newsTitle: UILabel!
    
    @IBOutlet weak private var newsImage: UIImageView!
    
     func setupView(cellVM: TopArticleListCellViewModel) {
        self.newsTitle.text = cellVM.titleText
        self.newsCoverBy.text = cellVM.authorText
        self.newsImage.downloadImageFromURL(cellVM.imageUrl,icon: UIImage(named: "placeholder"))
    }
}
