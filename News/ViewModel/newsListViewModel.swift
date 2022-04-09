//
//  newsListViewModel.swift
//  News
//
//  Created by Anbusekar Murugesan on 05/04/2022.
//

import Foundation
import Alamofire



class NewsViewModel {
    
    var model: NewsListModel
    var dataSource: NewsList?
    var startDate: Date = Date()
    var endDate: Date? {
        var dateComponent = DateComponents()
        dateComponent.month = 1
        return Calendar.current.date(byAdding: dateComponent, to: startDate)
        
    }
    
    init(Movies: NewsListModel) {
        self.model = NewsListModel()
    }
    
    func fetchMovies(startDate: String, endDate: String, successBlock: @escaping NewsModelProtocol.NewsListSuccessBlock, failureBlock: @escaping NewsModelProtocol.NewsListFailureBlock) {
        model.FetchNewsList(startDate: startDate, endDate: endDate) { newsList, status in
            successBlock(newsList, status)
        } failureBlock: { withResponse, failureStatus in
            failureBlock(withResponse, failureStatus)
        }

    }
    
}
