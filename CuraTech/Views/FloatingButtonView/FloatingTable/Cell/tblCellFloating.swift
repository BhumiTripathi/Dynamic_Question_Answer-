//
//  tblCellFloating.swift
//  CuraTech
//
//  Created by Bhumika tripathi on 8/11/18.
//  Copyright © 2018 Bhumika tripathi. All rights reserved.
//

import UIKit

class tblCellFloating: UITableViewCell {

    @IBOutlet var imgCellFloating: UIImageView!
    @IBOutlet var lblCellFloating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCornerRadiusOnCategoryLabel() {
        lblCellFloating.clipsToBounds = true
        lblCellFloating.layer.cornerRadius = lblCellFloating.frame.height
        imgCellFloating.clipsToBounds = true
        imgCellFloating.layer.cornerRadius = imgCellFloating.frame.height/2
        layoutSubviews()
    }

}
