//
//  NewsDetailTableViewController.swift
//  News
//
//  Created by shisheo portal on 05/03/2022.
//

import UIKit

final class NewsDetailViewController: UITableViewController {
    var news: NewsDetail
    var savedNews: SavedNews?
    var newsIsSaved = false
    init(with news: NewsDetail, savedNews: SavedNews?) {
        self.news = news
        self.savedNews = savedNews
        super.init(style: .plain)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}
 
private extension NewsDetailViewController {
    func setup() {
        title = "News Detail"
        tableView.separatorStyle = .none
        tableView.register(NewsDetailCell.self, forCellReuseIdentifier: NewsDetailCell.identifier)
        switch self.savedNews?.newViewType {
        case .news:
            let save = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(SaveTapped))
            navigationItem.rightBarButtonItems = [save]
        default: break
        }

     
    }
   @objc func SaveTapped(sender: UIBarButtonItem) {
           if !newsIsSaved {
               self.savedNews?.news.append(self.news)
               newsIsSaved = true
           }
       }
}

// MARK: - Table view data source

extension NewsDetailViewController {
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: NewsDetailCell.self, for: indexPath)
        cell.setData(for: self.news)
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

