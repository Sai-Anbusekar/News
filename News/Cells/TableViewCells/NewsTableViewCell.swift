//
//  NewsTableViewCell.swift
//  News
//
//  Created by Anbusekar Murugesan on 05/04/2022.
//

import UIKit
import Alamofire

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateTitle: UILabel!
    @IBOutlet weak var NewsTitle: UILabel!
    @IBOutlet weak var NewsImageView: UIImageView!

    static let identifierForCell = "NewsTableViewCell"
    var newsImage: UIImage?
    var  viewModel: NewsViewModel?
    var row: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NewsImageView.layer.cornerRadius = 5
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func updateCell(with news: Article?) {
        
        if self.viewModel?.dataSource?.articles[self.row ?? 0].Newsimage == nil {
            if  let remoteImageURL = URL(string: news?.urlToImage ?? "") {
                AF.request(remoteImageURL).responseData { (response) in
                    if response.error == nil {
                        print(response.result)
                        if let data = response.data {
                            self.viewModel?.dataSource?.articles[self.row ?? 0].Newsimage = data
                            if let imageData = self.viewModel?.dataSource?.articles[self.row ?? 0].Newsimage {
                                self.newsImage = UIImage(data: imageData)
                            }
                            self.internalUpdate(article: news)
                        }
                    }
                }

            } else  {
                if let data = self.viewModel?.dataSource?.articles[self.row ?? 0].Newsimage {
                    self.newsImage = UIImage(data: data)
                    self.internalUpdate(article: news)
                }
            }

        }
       
    }
    
    private func internalUpdate(article: Article?) {
        NewsImageView.image = newsImage
        NewsTitle.text = article?.title
        if let publishedDate = article?.publishedAt {
            updateDateAndTime(publishedAt: publishedDate)
        }
    }
    
    private func updateDateAndTime(publishedAt : String) {
        let format = DateFormatter()
        format.timeZone = .current
        format.dateFormat = "dd MMM, yyyy hh:mm a"
        dateTitle.text = format.date(from: publishedAt)?.description
    }
    
}


