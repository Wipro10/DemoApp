//
//  DetailsViewController.swift
//  BankDemo
//
//  Created by Santanu on 18/03/2022.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    var topStoryViewModel : TopStoryDetailsViewModel?
    @IBOutlet weak var newsImage: UIImageView?
    @IBOutlet weak var newsTitle: UILabel?
    @IBOutlet weak var newsDesc: UILabel?
    @IBOutlet weak var newsAuthor: UILabel?
    @IBOutlet weak var newsDate: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        viewSetUp()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = Strings.newsDetails
    }
    func viewSetUp()  {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.newsImage?.downloadImageFromURL(topStoryViewModel?.imageUrl ?? "" ,icon: UIImage(named: "placeholder"))
        self.newsTitle?.text = topStoryViewModel?.titleText
        self.newsDesc?.text = topStoryViewModel?.detailsText
        self.newsAuthor?.text = topStoryViewModel?.authorText
        self.newsDate?.text = topStoryViewModel?.dateText
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let webVC = segue.destination as? WebLinkViewController else { return }
        webVC.weblink = topStoryViewModel?.seeMoreLink
    }
}
