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
    
    private var topStories: [TopStories] = [TopStories]()
    
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
    
    func createCellViewModel( topStory: TopStories ) -> TopStoriesListCellViewModel {
        
        let multimdeia = topStory.multimedia?.filter{
            $0.format == ImageSize.thumbLarge
        }
        
        let imageUrl =  (multimdeia?.count) ?? 0  > 0 ? multimdeia?[0].url : ""
        
        return TopStoriesListCellViewModel(titleText: topStory.title ??
                                               "" , authorText: topStory.byline ?? "" , imageUrl: imageUrl ?? "")
    }
    
    private func processFetchedTopStories( topStories: [TopStories] ) {
        self.topStories = topStories // Cache
        var vms = [TopStoriesListCellViewModel]()
        for topStory in topStories {
            vms.append( createCellViewModel(topStory: topStory) )
        }
        self.cellViewModels = vms
    }
    
}

extension HomeViewModel {
    func userPressed( at indexPath: IndexPath ){
        let topStory = self.topStories[indexPath.row]
        let multimdeia = topStory.multimedia?.filter{
            $0.format == ImageSize.mediumThreeByTwo210
        }
        let imageUrl =  (multimdeia?.count ?? 0) > 0 ? multimdeia?[0].url : ""
        var dateString = ""
        if (topStory.published_date != nil){
            guard let dateArray = topStory.published_date?.components(separatedBy: "T") else { return }

            dateString = dateArray.count > 0 ? dateArray[0]  : ""
        }
        self.selectedTopStory = TopStoryDetailsViewModel(titleText: topStory.title ?? "", authorText: topStory.byline ?? "", imageUrl: imageUrl ?? "", dateText: dateString, detailsText: topStory.abstract ?? "", seeMoreLink: topStory.url ?? "" , subSection: topStory.subsection ?? "")
        
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
