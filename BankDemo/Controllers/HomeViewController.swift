//
//  ViewController.swift
//  BankDemo
//
//  Created by Santanu on 18/03/2022.
//

import UIKit

class HomeViewController: UIViewController,APIresponseDeleagte {
    @IBOutlet weak var newsTableView: UITableView?
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView?
    lazy var viewModel: HomeViewModel = {
        return HomeViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newsTableView?.accessibilityLabel = "newsTableView"
        initViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = Strings.homeTitle
    }
    func initViewModel() {
        viewModel.delegate = self
        viewModel.initFetch()
    }
    func completedApiRequest() {
        DispatchQueue.main.async {
            self.newsTableView?.reloadData()
        }
    }
    func showError() {
        if let message = self.viewModel.alertMessage {
            self.showAlert( message )
        }
    }
    func statusAPIRequest() {
        DispatchQueue.main.async {
            let isLoading = self.viewModel.isLoading
            if isLoading {
                self.loadingIndicator?.startAnimating()
                UIView.animate(withDuration: 0.2, animations: {
                    self.newsTableView?.alpha = 0.0
                })
            }else {
                self.loadingIndicator?.stopAnimating()
                UIView.animate(withDuration: 0.2, animations: {
                    self.newsTableView?.alpha = 1.0
                })
            }
        }
    }
    func showAlert( _ message: String ) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: Strings.alertTitle, message: message, preferredStyle: .alert)
            alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.newsCell , for: indexPath) as? NewsCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        let cellVM = viewModel.getCellViewModel( at: indexPath )
        cell.setupView(cellVM: cellVM)    
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let topStory = self.viewModel.userPressed(at: indexPath.row) else { return }
        let detailsViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: ViewControllerIdentifier.detailsViewController, creator: { coder -> DetailsViewController? in
             DetailsViewController(coder: coder, topStoryViewModel:topStory)
        })
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}


