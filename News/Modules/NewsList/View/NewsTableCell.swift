//
//  NewsTableCell.swift
//  News
//
//  Created by shisheo portal on 05/03/2022.
//

import UIKit
import Combine
final class NewsTableCell: UITableViewCell, LoadImageDataSource {
    private var cancellable: AnyCancellable?
    private var animator =  UIActivityIndicatorView(style: .medium)
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 1
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.textColor = .gray
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textColor = .gray
        return label
    }()
    private lazy var avater: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = UIImage(named: "placeholder")
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    override public func prepareForReuse() {
         super.prepareForReuse()
        disposeData()
     }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    func setData(for news: NewsDetail) {
        titleLabel.text = news.title
        descriptionLabel.text = news.datumDescription
        if let date = news.publishedAt?.getIsoDate()?.getDateTime() {
        dateLabel.text = date
        }
        setupImage(newsData: news)
    }

    private func setup() {
        contentView.addSubview(avater)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(descriptionLabel)
        avater.setConstrainsEqualToParent(edge: [.leading, .bottom, .top], with: 5)
        NSLayoutConstraint.activate([
            avater.widthAnchor.constraint(equalToConstant: 80),
            avater.heightAnchor.constraint(equalToConstant: 65)])
        dateLabel.setConstrainsEqualToParent(edge: [.trailing, .top], with: 8)
        NSLayoutConstraint.activate([
            dateLabel.widthAnchor.constraint(equalToConstant: 40),
            dateLabel.heightAnchor.constraint(equalToConstant: 20)])
        contentView.addSubview(titleLabel)
        titleLabel.setConstrainsEqualToParent(edge: [.top], with: 8)
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: avater.rightAnchor, constant: 5),
            titleLabel.rightAnchor.constraint(equalTo: dateLabel.leftAnchor, constant: -5)
        ])
        descriptionLabel.setConstrainsEqualToParent(edge: [.trailing, .bottom], with: 12)
        NSLayoutConstraint.activate([
            descriptionLabel.leftAnchor.constraint(equalTo: avater.rightAnchor, constant: 5)])
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: 0)])
        selectionStyle = .none
    }

    private func showImage(image: UIImage?) {
        avater.image = image
        animator.removeFromSuperview()
    }
    
    private func setupImage(newsData: NewsDetail) {
        guard let image = newsData.image, !image.isEmpty else {
            avater.image = UIImage(named: "placeholder")
            return }
        avater.addSubview(animator)
        animator.startAnimating()
        animator.center = avater.center
        cancellable = loadImage(for: newsData).sink { [weak self] image in self?.showImage(image: image) }
    }
    
    private func disposeData() {
        avater.image = nil
        animator.removeFromSuperview()
        cancellable?.cancel()
    }
}


