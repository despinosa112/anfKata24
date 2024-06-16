//
//  ANFExploreCardTableViewController.swift
//  ANF Code Test
//

import UIKit
import SDWebImage

class ANFExploreCardTableViewController: UITableViewController {
    
    private let apiClient = APIClient()
    
    private var exploreData: [Card]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Abercrombie & Fitch"
        tableView.register(ExploreCardCell.self, forCellReuseIdentifier: "ExploreCardCell")
        fetchExploreCards()
    }
    
    func fetchExploreCards(){
        apiClient.fetchExploreCards { result in
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
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ExploreCardCell", for: indexPath) as! ExploreCardCell
        configureCell(cell, for: indexPath)
        return cell
        
    }
    
    private func configureCell(_ cell: ExploreCardCell, for indexPath: IndexPath){
        //Reset views
        cell.stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        cell.stackView.addArrangedSubview(UIView.spacer())
        
        //Creating ViewModel
        let cardViewModel = CardViewModel(card: self.exploreData![indexPath.row])
        
        loadAsyncImage(cell, cardViewModel: cardViewModel, indexPath: indexPath)
        addCardItems(cell, cardViewModel: cardViewModel)
        addContentItems(cell, for: indexPath, cardViewModel: cardViewModel)
        
        //TODO: Fix so this doesn't break constraints
        cell.stackView.addArrangedSubview(UIView.spacer())
    }
    
    
    
    private func loadAsyncImage(_ cell: ExploreCardCell, cardViewModel: CardViewModel, indexPath: IndexPath){
        //Set Image
        if (cardViewModel.displayImage){
            cell.stackView.addArrangedSubview(cell.itemImageView)
            cell.stackView.setCustomSpacing(10.0, after: cell.itemImageView)
            
            if let imageURL = URL(string: cardViewModel.imageUrlString) {
                
                //Placeholder Image in case imageURL is bad or low connectivity
                let placeholderImage = UIImage(named: "Logo")
                let scaledImage = placeholderImage!.scaleToFitScreen()
                cell.itemImageView.image = scaledImage
                self.tableView.reloadRows(at: [indexPath], with: .none)
                
                SDWebImageManager.shared.loadImage(with: imageURL, progress: nil) { image, data, error, SDImageCacheType, Bool, URL in
                    //do Something
                    if error != nil {
                        print(error?.localizedDescription ?? "Error: image not loaded")
                        return
                    }
                    if let image = image {
                        let scaledImage = image.scaleToFitScreen()
                        cell.itemImageView.image = scaledImage
                        self.tableView.reloadRows(at: [indexPath], with: .none)
                    }
                }
            }
        }
    }
    
    
    private func addCardItems(_ cell: ExploreCardCell, cardViewModel: CardViewModel){
        if cardViewModel.displayTopDescriptionLabel {
            cell.topDescriptionLabel.text = cardViewModel.topDescriptionText
            cell.stackView.addArrangedSubview(cell.topDescriptionLabel)
            cell.stackView.setCustomSpacing(3.0, after: cell.topDescriptionLabel)
        }
        if cardViewModel.displayTitleLabel {
            cell.titleLabel.text = cardViewModel.titleText
            cell.stackView.addArrangedSubview(cell.titleLabel)
            cell.stackView.setCustomSpacing(3.0, after: cell.titleLabel)

        }
        if cardViewModel.displayPromoLabel {
            cell.promoMessageLabel.text = cardViewModel.promoText
            cell.stackView.addArrangedSubview(cell.promoMessageLabel)
            cell.stackView.setCustomSpacing(5.0, after: cell.promoMessageLabel)

        }
        if cardViewModel.displayBottomDescriptionButton {
            cell.bottomDescriptionButton.setTitle(cardViewModel.bottomDescriptionText, for: .normal)
            cell.bottomDescriptionButton.addTarget(self, action: #selector(pressedLinkButton(_:)), for: .touchUpInside)
            cell.bottomDescriptionButton.targetURLString = cardViewModel.bottomDescriptionURLString
            cell.stackView.addArrangedSubview(cell.bottomDescriptionButton)
            cell.stackView.setCustomSpacing(5.0, after: cell.bottomDescriptionButton)
        }
    }

    private func addContentItems(_ cell: ExploreCardCell, for indexPath: IndexPath, cardViewModel: CardViewModel){
        if cardViewModel.displayContent {
            cell.contentItemsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            for item in cardViewModel.contentItems {
                let contentViewModel = ContentItemViewModel(contentItem: item)
                let button = UIGenerator.createContentButton(title: contentViewModel.titleText, targetUrl: contentViewModel.target)
                button.addTarget(self, action: #selector(pressedLinkButton(_:)), for: .touchUpInside)
                cell.contentItemsStackView.addArrangedSubview(button)
            }
            cell.stackView.addArrangedSubview(cell.contentItemsStackView)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @objc func pressedLinkButton(_ sender: LinkButton) {
        guard let targetUrlString = sender.targetURLString else { return }
        let webView = WebViewController(urlString: targetUrlString)
        self.navigationController?.pushViewController(webView, animated: true)

    }
}
