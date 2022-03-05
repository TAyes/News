//
//  NewsDetailCell.swift
//  News
//
//  Created by shisheo portal on 05/03/2022.
//

import UIKit
import Combine
final class NewsDetailCell: UITableViewCell, LoadImageDataSource {
    private var cancellable: AnyCancellable?
    private var animator =  UIActivityIndicatorView(style: .large)
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var avater: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = UIImage(named: "placeholder")
        image.backgroundColor = .gray.withAlphaComponent(0.2)
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
    func setData(for newsData: NewsDetail) {
        titleLabel.text = newsData.title
        descriptionLabel.text = newsData.datumDescription
        setupImage(newsData: newsData)
    }

    private func setup() {
        contentView.addSubview(titleLabel)
        titleLabel.setConstrainsEqualToParent(edge: [.leading, .trailing, .top], with: 12)
        contentView.addSubview(avater)
        avater.setConstrainsEqualToParent(edge: [.leading, .trailing], with: 12)
        contentView.addSubview(descriptionLabel)
        descriptionLabel.setConstrainsEqualToParent(edge: [.leading, .trailing], with: 12)
        NSLayoutConstraint.activate([
            avater.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            avater.heightAnchor.constraint(equalToConstant: 250)
        ])
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: avater.bottomAnchor, constant: 12),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)])
        selectionStyle = .none
    }
    private func showImage(image: UIImage?) {
        avater.image = image
        animator.removeFromSuperview()
    }
    private func setupImage(newsData: NewsDetail) {
        guard let image = newsData.image, !image.isEmpty else {return}
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

