//
//  ErrorTableViewCell.swift
//  mrprint
//
//  Created by Engy Hussein on 6/7/18.
//  Copyright © 2018 mrprint. All rights reserved.
//

import UIKit

class ErrorTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = ""
    }
    
}
