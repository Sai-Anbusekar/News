//
//  NewsGridViewController.swift
//  News
//
//  Created by Anbusekar Murugesan on 05/04/2022.
//

import UIKit

class NewsGridViewController: NewsViewController {

    
    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK: - Variables
    
    var newsViewModelDetails: NewsViewModel?
    
    // MARK: - View Life Cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Custom Methods
    
    override func customiseUI() {
        super.customiseUI()
        registerCells()
        getNewsList()
    }
   
    private func getNewsList() {
        collectionView.reloadData()
        //        newsViewModelDetails?.fetchMovies { withResponse, successStatus in
        //            collectionView.reloadData()
        //        } failureBlock: { withResponse, failureStatus in
        //            
        //        }        // newsViewModelDetails.fetchNewsBasedOn(startDate: NewsHelper.convertStringFrom(date: newsViewModelDetails.startDate), endDate: NewsHelper.convertStringFrom(date: newsViewModelDetails.endDate ?? Date()), successBlock: { withResponse, successStatus in
        //            self.newsViewModelDetails.dataSource = withResponse
        //            self.collectionView.reloadData()
        //        }, failureBlock: { withResponse, failureStatus in
        //
        //        })
    }
    
    private func registerCells() {
        collectionView.register(UINib(nibName: "NewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: NewsCollectionViewCell.identifierForCell)
    }
    
    private func updateDataToListView() {
        let newsListVc = self.tabBarController?.viewControllers?[0] as? NewsListViewController
        if let data = newsViewModelDetails {
            newsListVc?.newsViewModelDetails = data
        }
    }

}


extension NewsGridViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        newsViewModelDetails?.dataSource?.articles.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell: NewsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionViewCell", for: indexPath) as? NewsCollectionViewCell {
            cell.updateCell(with: newsViewModelDetails?.dataSource?.articles[indexPath.row] )
            cell.delegate = self
            cell.currentIndexPath = indexPath
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        

        return CGSize(width: self.collectionView.frame.width / 2 , height: self.collectionView.frame.width / 2);
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let vc  = storyBoard.instantiateViewController(withIdentifier: "DetailNewsViewController") as? DetailNewsViewController {
            vc.modalPresentationStyle = .popover
            vc.article = newsViewModelDetails?.dataSource?.articles[indexPath.row]
            vc.delegate = self
            vc.selectedIndexPath = indexPath
            self.navigationController?.present(vc, animated: true, completion: nil)
        }
    }
    
}

extension NewsGridViewController: NewsCollectionViewCellDelegate, DetailNewsViewControllerDelegate {
    
    func likeButtonTapped(at: IndexPath) {
        if let isLiked = newsViewModelDetails?.dataSource?.articles[at.row].isLiked {
            newsViewModelDetails?.dataSource?.articles[at.row].isLiked = !isLiked
        } else {
            newsViewModelDetails?.dataSource?.articles[at.row].isLiked = true
        }
        updateDataToListView()
        collectionView.reloadItems(at: [at])
        
    }
    
}
