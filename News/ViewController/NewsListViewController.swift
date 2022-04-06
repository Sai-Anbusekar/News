//
//  NewsListViewController.swift
//  News
//
//  Created by Anbusekar Murugesan on 05/04/2022.
//

import UIKit

class NewsListViewController: NewsViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var newsViewModelDetails: NewsViewModel = NewsViewModel(Movies: NewsListModel())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }


    override func customiseUI() {
        super.customiseUI()
        registerCells()
        getNewsList()
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: NewsTableViewCell.identifierForCell)
    }
    
    private func getNewsList() {
        
        newsViewModelDetails.fetchMovies(page: 0, successBlock: { withResponse, successStatus in
            self.newsViewModelDetails.dataSource = withResponse
            self.tableView.reloadData()
        }, failureBlock: { withResponse, failureStatus in
            
        })
    }
    
}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.newsViewModelDetails.dataSource?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: NewsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell {
            cell.updateCell(with: self.newsViewModelDetails.dataSource?.articles[indexPath.row])
            cell.viewModel = newsViewModelDetails
            cell.row = indexPath.row
            return cell
            
        }
        return UITableViewCell()
    }
    
    
    
}
