//
//  NewsListViewController.swift
//  News
//
//  Created by Anbusekar Murugesan on 05/04/2022.
//

import UIKit

class NewsListViewController: NewsViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Variables
    var newsViewModelDetails: NewsViewModel = NewsViewModel(News: NewsListModel())
    
    
    // MARK: - View Life Cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
    }
    
    // MARK: - Custom methods
    override func customiseUI() {
        super.customiseUI()
        
        registerCells()
        getNewsList()
        
    }
    
    final func registerCells() {
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: NewsTableViewCell.identifierForCell)
       
    }
    
    private func getNewsList() {
        
        //FIXME: below code another type of timeline based fetch news which has pagination condept 
       /* newsViewModelDetails.fetchNewsBasedOn(startDate: NewsHelper.convertStringFrom(date: newsViewModelDetails.startDate), endDate: NewsHelper.convertStringFrom(date: newsViewModelDetails.endDate ?? Date()), successBlock: { withResponse, successStatus in
            if self.newsViewModelDetails.dataSource == nil {
                self.newsViewModelDetails.dataSource = withResponse
            } else {
                self.newsViewModelDetails.dataSource?.articles.append(contentsOf: withResponse.articles)
                self.newsViewModelDetails.dataSource?.totalResults = withResponse.totalResults
            }
            self.passDatatoGridView()
            
            self.tableView.reloadData()
            self.addingMonthsInDate()
        }, failureBlock: { withResponse, failureStatus in
            
        })*/
        
        newsViewModelDetails.fetchMovies { withResponse, successStatus in
            self.newsViewModelDetails.dataSource = withResponse
            self.passDatatoGridView()
            self.tableView.reloadData()
        } failureBlock: { withResponse, failureStatus in
            
        }
        
    }
    
    private func passDatatoGridView() {
        let secondTab = self.tabBarController?.viewControllers?[1] as? NewsGridViewController
        secondTab?.newsViewModelDetails = newsViewModelDetails
    }
    
    private func addingMonthsInDate() {
        newsViewModelDetails.startDate = newsViewModelDetails.endDate ?? Date()
    }
    
    
}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsViewModelDetails.dataSource?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: NewsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell {
            cell.updateCell(with: self.newsViewModelDetails.dataSource?.articles[indexPath.row])
            cell.viewModel = newsViewModelDetails
            cell.currentIndexPath = indexPath
            cell.delegate = self
            return cell
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let vc  = storyBoard.instantiateViewController(withIdentifier: "DetailNewsViewController") as? DetailNewsViewController {
            vc.modalPresentationStyle = .popover
            vc.article = newsViewModelDetails.dataSource?.articles[indexPath.row]
            vc.delegate = self
            vc.selectedIndexPath = indexPath
            self.navigationController?.present(vc, animated: true, completion: nil)
        }
    }
    
    //    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    //        if (((newsViewModelDetails.dataSource?.articles.count ?? 0) - 2) == indexPath.row) {
    //            getNewsList()
    //        }
    //    }
    
}

extension NewsListViewController: NewsTableViewCellDelegate, DetailNewsViewControllerDelegate {
    
    func likeButtonTapped(at: IndexPath) {
        if let isLiked = newsViewModelDetails.dataSource?.articles[at.row].isLiked {
            newsViewModelDetails.dataSource?.articles[at.row].isLiked = !isLiked
        } else {
            newsViewModelDetails.dataSource?.articles[at.row].isLiked = true
        }
        tableView.reloadRows(at: [at], with: .none)
    }
    
}

