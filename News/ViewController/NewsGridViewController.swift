//
//  NewsGridViewController.swift
//  News
//
//  Created by Anbusekar Murugesan on 05/04/2022.
//

import UIKit

class NewsGridViewController: NewsViewController {

    var newsViewModelDetails: NewsViewModel?

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func customiseUI() {
        super.customiseUI()
        registerCells()
        getNewsList()
    }
   
    private func getNewsList() {
        
//        newsViewModelDetails?.fetchMovies(startDate: <#T##String#>, endDate: <#T##String#>, successBlock: <#T##(NewsList, Bool?) -> Void##(NewsList, Bool?) -> Void##(_ withResponse: NewsList, _ successStatus: Bool?) -> Void#>, failureBlock: <#T##(AFError?, Bool?) -> Void##(AFError?, Bool?) -> Void##(_ withResponse: AFError?, _ failureStatus: Bool?) -> Void#>)
//        newsViewModelDetails?.fetchMovies(startDate: <#T##String#>, endDate: <#T##String#>, successBlock: <#T##(NewsList, Bool?) -> Void##(NewsList, Bool?) -> Void##(_ withResponse: NewsList, _ successStatus: Bool?) -> Void#>, failureBlock: <#T##(AFError?, Bool?) -> Void##(AFError?, Bool?) -> Void##(_ withResponse: AFError?, _ failureStatus: Bool?) -> Void#>, successBlock: { withResponse, successStatus in
//            self.newsViewModelDetails.dataSource = withResponse
//            self.collectionView.reloadData()
//        }, failureBlock: { withResponse, failureStatus in
//
//        })
    }
    
    private func registerCells() {
        collectionView.register(UINib(nibName: "NewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: NewsCollectionViewCell.identifierForCell)
    }

}


extension NewsGridViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        newsViewModelDetails?.dataSource?.articles.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell: NewsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionViewCell", for: indexPath) as? NewsCollectionViewCell {
            cell.updateCell(with: newsViewModelDetails?.dataSource?.articles[indexPath.row] )
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        

        return CGSize(width: self.collectionView.frame.width / 2 , height: self.collectionView.frame.width / 2);
    }
    
}
