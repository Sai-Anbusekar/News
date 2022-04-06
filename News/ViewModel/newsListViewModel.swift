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
    
    
    init(Movies: NewsListModel) {
        self.model = NewsListModel()
    }
    
    func fetchMovies(page: Int, successBlock: @escaping NewsModelProtocol.NewsListSuccessBlock, failureBlock: @escaping NewsModelProtocol.NewsListFailureBlock) {
        model.FetchNewsList(page: page) { newsList, status in
            successBlock(newsList, status)
        } failureBlock: { withResponse, failureStatus in
            failureBlock(withResponse, failureStatus)
        }

    }
    
}
