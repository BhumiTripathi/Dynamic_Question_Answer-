//
//  DetailVC+Enum.swift
//  CuraTech
//
//  Created by Bhumika tripathi on 8/11/18.
//  Copyright © 2018 Bhumika tripathi. All rights reserved.
//

import Foundation
import UIKit

extension DetailVC
{
    /*
     An enum is used for the identifiers
     1. datepicker - tblCellOtherTextField is loaded.
     2. picker - tblCellOtherTextField is loaded.
     3. text -  tblCellOtherTextView is shown.
     4. radio - tblCellRadio is shown.
     5. checkbox - tblCellRadio is shown.
     */
    enum strType : String
    {
        case radio = "tblCellRadio"
        case question = "TblCellAnswer"
        case text = "tblCellOtherTextField"
        case textView = "tblCellOtherTextView"
    }
}

extension UITextView {
    /*
     To add the layer on the textview.
     */
    func setUITextView()
    {
        self.layer.cornerRadius = 8.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightText.cgColor
        self.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.7
        self.layer.masksToBounds = false
    }
}
