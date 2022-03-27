//
//  HomeViewModel.swift
//  BankDemo
//
//  Created by Santanu on 18/03/2022.
//

import Foundation
import UIKit

protocol APIresponseDeleagte: AnyObject{
    func completedApiRequest()
    func showError()
    func statusAPIRequest()
}
class HomeViewModel {
    public weak var delegate: APIresponseDeleagte?
    let apiService: APIServiceProtocol
    
    private var topStories: [TopStorie] = [TopStorie]()
    
    private var cellViewModels: [TopStoriesListCellViewModel] = [TopStoriesListCellViewModel]() {
        didSet {
            self.delegate?.completedApiRequest()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            self.delegate?.statusAPIRequest()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.delegate?.showError()
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    var selectedTopStory: TopStoryDetailsViewModel?
    
    
    init( apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func initFetch() {
        self.isLoading = true
        apiService.fetchTopStories { [weak self] (success, results, error) in
            self?.isLoading = false
            if let error = error {
                self?.alertMessage = error.localizedDescription
            } else {
                self?.processFetchedTopStories(topStories: results)
            }
        }
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> TopStoriesListCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCellViewModel( topStory: TopStorie ) -> TopStoriesListCellViewModel {
        
        let multimdeia = topStory.imageGallery?.filter{
            $0.imageFormat == ImageSize.thumbLarge
        }
        
        let imageUrl =  (multimdeia?.count) ?? 0  > 0 ? multimdeia?[0].imageUrl : ""
        
        return TopStoriesListCellViewModel(titleText: topStory.newsTitle , authorText: topStory.newsByLine ?? "" , imageUrl: imageUrl ?? "")
    }
    
    private func processFetchedTopStories( topStories: [TopStorie] ) {
        self.topStories = topStories // Cache
        var vms = [TopStoriesListCellViewModel]()
        for topStory in topStories {
            vms.append( createCellViewModel(topStory: topStory) )
        }
        self.cellViewModels = vms
    }
    
}

extension HomeViewModel {
    func userPressed( at: Int ) -> TopStoryDetailsViewModel?{
        let topStory = self.topStories[at]
        let multimdeia = topStory.imageGallery?.filter{
            $0.imageFormat == ImageSize.mediumThreeByTwo210
        }
        let imageUrl =  (multimdeia?.count ?? 0) > 0 ? multimdeia?[0].imageUrl : ""
        var dateString = ""
        if (topStory.newsPublishedDate != nil){
            guard let dateArray = topStory.newsPublishedDate?.components(separatedBy: "T") else { return nil }

            dateString = dateArray.count > 0 ? dateArray[0]  : ""
        }
        self.selectedTopStory = TopStoryDetailsViewModel(titleText: topStory.newsTitle , authorText: topStory.newsByLine ?? "", imageUrl: imageUrl ?? "", dateText: dateString, detailsText: topStory.newsAbstract , seeMoreLink: topStory.newsWebUrl , subSection: topStory.newSubsection)
        return self.selectedTopStory
        
    }
}

struct TopStoriesListCellViewModel {
    let titleText: String
    let authorText: String
    let imageUrl: String
}

struct TopStoryDetailsViewModel {
    let titleText: String
    let authorText: String
    let imageUrl: String
    let dateText: String
    let detailsText :String
    let seeMoreLink : String
    let subSection : String
    
}
