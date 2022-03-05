//
//  NewsUIViewController.swift
//  News
//
//  Created by shisheo portal on 05/03/2022.
//

import UIKit

final class NewsTableController: UIViewController {
    private let viewModel: NewsViewModelType
    private var dataList: [NewsDetail] = []
    let tableView = UITableView()
    let buttonStackView = UIStackView()
    let savedNewsbutton = UIButton()
    let newsbutton = UIButton()
    var newsListSelected : Bool = true {
        didSet {
            title = newsListSelected ?  "News" : "Saved News"
        }
    }
    init(with viewModel: NewsViewModelType = NewsViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindToViewModel()
        addBottomView()
    }
}

// MARK: - Table view data source

extension NewsTableController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: NewsTableCell.self, for: indexPath)
        cell.setData(for: dataList[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AppNavigator.shared.push(.detail(dataList[indexPath.row], viewModel.savedNews))
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == dataList.count {
            viewModel.loadMoreData()
        }
    }
}


// MARK: - Private

private extension NewsTableController {
    func bindToViewModel() {
        viewModel.newsList.subscribe { [weak self] data in
            self?.dataList = data
            self?.tableView.reloadData()
        }

        viewModel.error.subscribe { [weak self] error in
            guard let self = self, let msg = error else { return }
            self.show(error: msg)
        }
    }

    func setup() {
        newsListSelected = true
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(NewsTableCell.self, forCellReuseIdentifier: NewsTableCell.identifier)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    func addBottomView() {
        let bottomView = UIView()
        view.addSubview(bottomView)
        bottomView.setConstrainsEqualToParent(edge: [.leading, .trailing, .bottom], with: 0)
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 0)])
           bottomView.backgroundColor = .white // or your color
        newsbutton.setTitle("News", for: .normal)
        newsbutton.translatesAutoresizingMaskIntoConstraints = false
        newsbutton.addTarget(self, action: #selector(news), for: .touchUpInside)
        savedNewsbutton.setTitle("Saved News", for: .normal)
        savedNewsbutton.translatesAutoresizingMaskIntoConstraints = false
        savedNewsbutton.addTarget(self, action: #selector(savedNews), for: .touchUpInside)
        setupColorButtons(hightLightButton: newsbutton, unHighlightedButton: savedNewsbutton)
        bottomView.addSubview(buttonStackView)
        buttonStackView.setConstrainsEqualToParent(edge: [.all])
        buttonStackView.alignment = .fill
          buttonStackView.distribution = .fillEqually
          buttonStackView.spacing = 8.0
          buttonStackView.addArrangedSubview(newsbutton)
          buttonStackView.addArrangedSubview(savedNewsbutton)
    }
    @objc func news() {
        newsListSelected = true
        viewModel.showNewsList(for: .news)
        setupColorButtons(hightLightButton: newsbutton, unHighlightedButton: savedNewsbutton)
    }
    @objc func savedNews() {
        newsListSelected = false
        viewModel.showNewsList(for: .savednews)
        setupColorButtons(hightLightButton: savedNewsbutton, unHighlightedButton: newsbutton)
    }
    func setupColorButtons(hightLightButton: UIButton, unHighlightedButton: UIButton) {
        hightLightButton.setTitleColor(.blue, for: .normal)
        unHighlightedButton.setTitleColor(.black, for: .normal)
    }
}
