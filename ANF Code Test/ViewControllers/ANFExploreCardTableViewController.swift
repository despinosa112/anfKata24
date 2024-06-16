//
//  ANFExploreCardTableViewController.swift
//  ANF Code Test
//

import UIKit

class ANFExploreCardTableViewController: UITableViewController {
    
    private var exploreData: [Card]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ExploreCardCell.self, forCellReuseIdentifier: "ExploreContentCell")
        fetchExploreCards()
        registerImageLoadedNotification()
    }
    
    func registerImageLoadedNotification(){
        let notificationName = Notification.Name(Constants.asyncImageLoaded)
        NotificationCenter.default.addObserver(forName: notificationName, object: nil, queue: nil) { notification in
            if let userInfo = notification.userInfo {
                if let indexPath = userInfo["indexPath"] as? IndexPath {
                    self.tableView.reloadRows(at: [indexPath], with: .none)
                }

            }
        }
    }
    
    func fetchExploreCards(){
        APICLient.fetchExploreCards { result in
            switch result {
            case .success(let exploreCards):
                self.exploreData = exploreCards
            case .failure(let error):
                print("Error fetching content: \(error)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cardCount = self.exploreData?.count ?? 0
        return cardCount
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ExploreContentCell", for: indexPath) as! ExploreCardCell
        let cardViewModel = CardViewModel(card: self.exploreData![indexPath.row])
        cell.indexPath = indexPath
        cell.stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        cell.topDescriptionLabel.text = cardViewModel.topDescriptionText
        cell.titleLabel.text = cardViewModel.topTitleText
        cell.promoMessageLabel.text = cardViewModel.promoText
    
        //BottomDescription
        cell.bottomDescriptionButton.setTitle(cardViewModel.bottomDescriptionText, for: .normal)
        cell.bottomDescriptionButton.addTarget(self, action: #selector(pressedLinkButton(_:)), for: .touchUpInside)
        cell.bottomDescriptionButton.targetURLString = cardViewModel.bottonDescriptionURLString

        
        if cardViewModel.displayImage {
            cell.stackView.addArrangedSubview(cell.cardImageView)
            if let url = URL(string: cardViewModel.urlString) {
                cell.configure(with: url)
            }
        }
        
        if cardViewModel.displayTopDescriptionLabel {
            cell.stackView.addArrangedSubview(cell.topDescriptionLabel)
        }
        
        if cardViewModel.displayTitleLabel {
            cell.stackView.addArrangedSubview(cell.titleLabel)
        }
        
        if cardViewModel.displayPromoLabel {
            cell.stackView.addArrangedSubview(cell.promoMessageLabel)
        }
        
        if cardViewModel.displayBottomDescriptionButton {
            //cell.stackView.addArrangedSubview(cell.bottomDescriptionLabel)
            cell.stackView.addArrangedSubview(cell.bottomDescriptionButton)
        }
        
        if cardViewModel.displayContent {
            cell.contentStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            for item in cardViewModel.contentList {
                let contentViewModel = ContentViewModel(content: item)
                let button = LinkButton(type: .system)
                button.setTitle(contentViewModel.titleText, for: .normal)
                button.layer.borderColor = UIColor.black.cgColor
                button.layer.borderColor = UIColor.black.cgColor
                button.layer.borderWidth = 1.0
                button.addTarget(self, action: #selector(pressedLinkButton(_:)), for: .touchUpInside)
                button.targetURLString = contentViewModel.target
                cell.contentStackView.addArrangedSubview(button)
            }
            cell.stackView.addArrangedSubview(cell.contentStackView)
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
        //return 200
    }
    
    @objc func pressedLinkButton(_ sender: LinkButton) {
        let targetUrlString = sender.targetURLString
        print("Link Button tapped\(targetUrlString)")
    }
}
