//
//  CollectionViewCell.swift
//  CompositionalLayout_Demo2
//
//  Created by ankit bharti on 14/10/19.
//  Copyright © 2019 ankit kumar bharti. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.cornerRadius = 8.0
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    func configure(_ text: String) {
        self.messageLabel.text = text
    }
}
