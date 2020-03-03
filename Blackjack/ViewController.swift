//
//  ViewController.swift
//  Blackjack
//
//  Created by abe on 2/25/20.
//  Copyright © 2020 thoughtbot. All rights reserved.
//

import UIKit
import SDWebImage
import Combine

enum Section {
    case main
}

class ViewController: UIViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Card>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Card>
        
    private var dataSource: DataSource!
    
    var hand = Hand()

    var subscription: AnyCancellable!

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var dealButton: UIButton!
    @IBOutlet weak var deck: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDataSource()
        dealButton.layer.cornerRadius = dealButton.frame.size.height/4
    }


    func deal() {
        let publisher = (hand.cards.isEmpty) ? DealerService.dealFromNewDeck() : DealerService.dealFromDeck(with: hand.deck_id!)
        
        subscription = publisher
            .sink(receiveCompletion: { completion in
                if case .failure(let err) = completion {
                    print("Retrieving data failed with error \(err)")
                }
            }, receiveValue: { object in
                self.hand.deck_id = object.deck_id
                self.hand.cards.append(object.cards!.first!)
                self.updateHand(with: self.hand.cards)
                self.updateTitles(cardsRemaining: object.remaining)
            })
    }
    
    @IBAction func draw(_ sender: Any) {
        if hand.score >= 21 {
            hand.cards.removeAll()
        }
        deal()
    }
    
    func updateTitles(cardsRemaining: Int) {
        DispatchQueue.main.async {
            if !self.hand.cards.isEmpty {
                self.title = String(self.hand.score)
                self.dealButton.setTitle("Deal", for: .normal)
            } else {
                self.title = "Blackjack"
            }

            if self.hand.score > 21 {
                self.dealButton.setTitle("Busted", for: .normal)
            }
            if self.hand.score == 21 {
                self.dealButton.setTitle("🎊21🎉", for: .normal)
            }
            self.deck.title = String(cardsRemaining)
        }
    }
    
}

extension ViewController {
   
    func setUpDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, card) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.reuseIdentifier, for: indexPath) as! CardCell
            cell.imageView.sd_setImage(with: URL(string: card.image))
            return cell
        })
    }
    
    func updateHand(with cards: [Card]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(cards)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
}


