//
//  DetailNewsViewController.swift
//  News
//
//  Created by Anbusekar Murugesan on 09/04/2022.
//

import UIKit
import Alamofire

protocol DetailNewsViewControllerDelegate {
    func likeButtonTapped(at: IndexPath)
}

class DetailNewsViewController: NewsViewController {
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var publishedAtLabel: UILabel!
    @IBOutlet weak var newsDescribtion: UILabel!
    @IBOutlet weak var likeButton: LikeButton!
    
    
    var article: Article?
    var delegate: DetailNewsViewControllerDelegate?
    var selectedIndexPath: IndexPath?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        if article?.isLiked == true {
            article?.isLiked = false
            likeButton.unLiked()
        } else {
            article?.isLiked = true
            likeButton.liked()
        }
        if let path = selectedIndexPath {
            delegate?.likeButtonTapped(at: path)
        }
    }
    
    override func customiseUI() {
        super.customiseUI()
        loadNewsImage()
        newsTitle.text = article?.title
        newsDescribtion.text = article?.articleDescription
        if let pubAt = article?.publishedAt {
            publishedAtLabel.text = NewsHelper.convertToUTC(dateToConvert: pubAt)
        }
        if article?.isLiked == true {
            likeButton.liked()
        } else {
            likeButton.unLiked()
        }
        
    }
    
    
    private func loadNewsImage() {
        if  let remoteImageURL = URL(string: article?.urlToImage ?? "") {
            AF.request(remoteImageURL).responseData { (response) in
                if response.error == nil {
                    print(response.result)
                    if let data = response.data {
                        self.newsImage.image = UIImage(data: data)
                        
                    }
                }
            }
            
        }
    }
    
}
