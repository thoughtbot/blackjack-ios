//
//  CardCell.swift
//  Blackjack
//
//  Created by abe on 2/25/20.
//  Copyright © 2020 thoughtbot. All rights reserved.
//
import UIKit

class CardCell: UICollectionViewCell, SelfIdentifing {
        
    @IBOutlet weak var imageView: UIImageView!
        
    override func awakeFromNib() {
        self.layer.cornerRadius = 8
    }
        
}

protocol SelfIdentifing {
    static var reuseIdentifier: String { get }
}

extension SelfIdentifing {
    static var reuseIdentifier: String {
        return "\(self)"
    }
}
