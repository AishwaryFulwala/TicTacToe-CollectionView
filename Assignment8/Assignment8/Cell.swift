//
//  Cell.swift
//  Assignment8
//
//  Created by DCS on 06/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class Cell: UICollectionViewCell {
    private let iv : UIImageView = {
        let i = UIImageView()
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        return i
    }()
    
    func disp(with status: Int) {
        contentView.addSubview(iv)
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.layer.backgroundColor = UIColor.clear.cgColor
        
        iv.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        
        let name = status == 1 ? "o.png" : status == 2 ? "x.png" : ""
        iv.image = UIImage(named: name)
    }
}
