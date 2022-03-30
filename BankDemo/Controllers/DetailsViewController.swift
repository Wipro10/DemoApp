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
    @IBOutlet weak private var newsImage: UIImageView!
    @IBOutlet weak private var newsTitle: UILabel!
    @IBOutlet weak private var newsDesc: UILabel!
    @IBOutlet weak private var newsAuthor: UILabel!
    @IBOutlet weak private var newsDate: UILabel!
    
    init?(coder: NSCoder, topStoryViewModel: TopStoryDetailsViewModel) {
        self.topStoryViewModel = topStoryViewModel
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        fatalError("Use `init(coder:topStoryViewModel:)` to initialize an `DetailsViewController` instance.")
    }
    
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
    
    @IBAction func openWebKit(_ sender: Any) {
        let webLinkViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: ViewControllerIdentifier.webLinkViewController, creator: { coder -> WebLinkViewController? in
                WebLinkViewController(coder: coder, websiteLink: self.topStoryViewModel?.seeMoreLink ?? "")
            })
        self.navigationController?.pushViewController(webLinkViewController, animated: true)
    }
}
