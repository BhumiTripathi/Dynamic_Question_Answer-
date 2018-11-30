//
//  TblCellDataListing.swift
//  CuraTech
//
//  Created by Bhumika tripathi on 8/11/18.
//  Copyright © 2018 Bhumika tripathi. All rights reserved.
//

import UIKit

class TblCellDataListing: UITableViewCell {

    @IBOutlet var btnAnswer: UIButton!
    @IBOutlet var viewBack: UIView!
    @IBOutlet var lblTitle: UILabel!
    
    @IBOutlet var btnDetail: UIButton!
    
    override func awakeFromNib() {
        
        lblTitle.font = UIFont(name: "Georgia", size: AppConstant.IS_IPAD ? 25 : 17)!
        btnAnswer.titleLabel?.font = UIFont(name: "Georgia", size: AppConstant.IS_IPAD ? 15 : 10)!

        
    }
    
    func setQuestionsDatainsideCell(dictValue : Questions)
    {
        addShadowAndCornerToView()
        lblTitle.text = dictValue.question;
        lblTitle.tag = dictValue.id
        btnDetail.setTitle("Answer Now", for: .normal)
        btnDetail.isHidden = false
        if dictValue.Answer != "" || dictValue.arrAnswer.count != 0 {        btnDetail.setTitle("Update", for: .normal)
        }
    }
    
    func addShadowAndCornerToView()
    {
        viewBack.layer.cornerRadius = 4.0
        viewBack.layer.borderWidth = 1.0
        viewBack.layer.borderColor = UIColor.lightText.cgColor
        viewBack.layer.masksToBounds = true
        
        viewBack.layer.shadowColor = UIColor.darkGray.cgColor
        viewBack.layer.shadowOffset = CGSize(width: 0, height: 0)
        viewBack.layer.shadowRadius = 3.0
        viewBack.layer.shadowOpacity = 0.7
        viewBack.layer.masksToBounds = false
    }
    
}
