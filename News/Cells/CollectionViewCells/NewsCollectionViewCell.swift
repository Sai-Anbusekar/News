//
//  NewsCollectionViewCell.swift
//  News
//
//  Created by Anbusekar Murugesan on 07/04/2022.
//

import UIKit
import Alamofire

class NewsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsPublishedDateLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    static let identifierForCell = "NewsCollectionViewCell"
    let activityIndicator = UIActivityIndicatorView()
    var news: Article?
    var newsImage: UIImage?
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.frame = contentView.frame
        newsImageView.layer.cornerRadius = 5
    }
    
    
    func updateCell(with news: Article?) {
        startLoading()
        
            if  let remoteImageURL = URL(string: news?.urlToImage ?? "") {
                AF.request(remoteImageURL).responseData { (response) in
                    if response.error == nil {
                        print(response.result)
                        if let data = response.data {
                            self.stopLoading()
                            self.newsImage = UIImage(data: data)
                            self.internalUpdate(article: news)
                        }
                    }
                }
                
            }
            
        
        
    }
    
    private func startLoading() {
        contentView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func stopLoading() {
        activityIndicator.startAnimating()
        activityIndicator.removeFromSuperview()
    }
    

    private func internalUpdate(article: Article?) {
        newsImageView.image = newsImage
        newsTitleLabel.text = article?.title
        newsPublishedDateLabel.text = NewsHelper.convertToUTC(dateToConvert: article?.publishedAt ?? "")
    }
    
}
