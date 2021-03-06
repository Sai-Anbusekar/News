//
//  newsListModel.swift
//  News
//
//  Created by Anbusekar Murugesan on 05/04/2022.
//

import Foundation
import Alamofire


// MARK: - Article List
struct NewsList: Codable {
    let status: String
    var totalResults: Int
    var articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let articleDescription: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    var Newsimage: Data?
    var isLiked: Bool? = false
    
    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
        case Newsimage
        case isLiked
    }
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}


protocol NewsModelProtocol {
    
    typealias NewsListFailureBlock = (_ withResponse: AFError?, _ failureStatus: Bool?) -> Void
    typealias NewsListSuccessBlock = (_ withResponse: NewsList, _ successStatus: Bool?) -> Void
    
    func FetchNewsListBasedOn(startDate:String, endDate: String, successBlock: @escaping NewsModelProtocol.NewsListSuccessBlock, failureBlock: @escaping NewsListFailureBlock)
    
}


class NewsListModel: NSObject, NewsModelProtocol  {
    
    func FetchNewsListBasedOn(startDate:String, endDate: String, successBlock: @escaping (NewsList, Bool?) -> Void, failureBlock: @escaping NewsListFailureBlock) {
        
        if let requestUrl = URL(string: "\(baseUrl)everything?q=apple&from=\(startDate)&to=\(endDate)&sortBy=popularity&apiKey=\(apiKey)") {
            _ = NewsAlamofire.getRequest(url: requestUrl, parameters: nil, successBlock: { withResponse, status in
                if let response = withResponse?.data {
                    do {
                        let newsData = try JSONDecoder().decode(NewsList.self, from: response)
                        successBlock(newsData, status)
                    }
                    catch {
                        print(error.localizedDescription)
                        failureBlock(nil, status)
                    }
                } else {
                    failureBlock(nil, false)
                }
                
            }, failureBlock: { withError, cancelStatus in
                failureBlock(withError, cancelStatus)
            })
        }
    }
    
    func FetchNewsList(successBlock: @escaping (NewsList, Bool?) -> Void, failureBlock: @escaping NewsListFailureBlock) {
        
        if let requestUrl = URL(string: "\(baseUrl)top-headlines?country=us&category=business&apiKey=\(apiKey)") {
            _ = NewsAlamofire.getRequest(url: requestUrl, parameters: nil, successBlock: { withResponse, status in
                if let response = withResponse?.data {
                    do {
                        let newsData = try JSONDecoder().decode(NewsList.self, from: response)
                        successBlock(newsData, status)
                    }
                    catch {
                        print(error.localizedDescription)
                        failureBlock(nil, status)
                    }
                } else {
                    failureBlock(nil, false)
                }
                
            }, failureBlock: { withError, cancelStatus in
                failureBlock(withError, cancelStatus)
            })
        }
    }
    
}
