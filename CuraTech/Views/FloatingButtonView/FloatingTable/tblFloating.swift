//
//  tblFloating.swift
//  CuraTech
//
//  Created by Bhumika tripathi on 8/11/18.
//  Copyright © 2018 Bhumika tripathi. All rights reserved.
//

import UIKit

class tblFloating: UIView, UITableViewDataSource, UITableViewDelegate,UIGestureRecognizerDelegate {

    @IBOutlet var viewBack: UIView!
    @IBOutlet var tblViewFloating: UITableView!
    typealias tblDidSelectCompletionBlock = (_ strValue:String) ->Void
    var tblSelectedBlock : tblDidSelectCompletionBlock?
    var shownIndexes : [IndexPath] = []
    var delayTime : Double = 0.0
    var aCellHeight : Int = 50
    var aTblHeight : Int = 0
//    var pickerDelegate : QGTextFamilyDelegate?
    var arrTextData = [String]()
    var arrImageData = [String]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpNib()
    }
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
        setUpNib()
        // getCategoriesFromDB()
    }
   
    func setUpNib() {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "tblFloating", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        self.tblViewFloating.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tblViewFloating.backgroundColor = UIColor.clear
        self.tblViewFloating.bounces = false
        self.tblViewFloating.showsHorizontalScrollIndicator = false
        self.tblViewFloating.showsVerticalScrollIndicator = false
        self.tblViewFloating.register(UINib(nibName: "tblCellFloating", bundle: nil), forCellReuseIdentifier: "tblCellFloating")
        
    }
    
    func addTable(_ sourceController : UIViewController, strSelectedValue: String, arrText : [String], arrImage : [String], aXpos:Int, aYpos:Int, cellHeight:Int, tblWidth:Int , animationDelay:Double, withCompletionBlock : @escaping tblDidSelectCompletionBlock) {
        sourceController.view.endEditing(true)
        arrTextData = arrText
        arrImageData = arrImage
        tblSelectedBlock = withCompletionBlock
        //controllerForHelp = sourceController
        aCellHeight = cellHeight
        aTblHeight = arrTextData.count * Int(aCellHeight)
        delayTime = Double(arrTextData.count) * animationDelay
        
        self.frame = CGRect(x: 0, y: -20, width: FRAME_WIDTH, height: FRAME_HEIGHT+80)
        self.viewBack.setNeedsLayout()
        if AppConstant.IS_IPHONE_5
        {
            self.tblViewFloating.frame = CGRect(x: aXpos, y: Int(FRAME_HEIGHT)-aTblHeight-105, width: tblWidth, height: aTblHeight)
        }
        else
        {
            self.tblViewFloating.frame = CGRect(x: aXpos, y: Int(FRAME_HEIGHT)-aTblHeight-130, width: tblWidth, height: aTblHeight)
            
        }
        self.tblViewFloating.setNeedsLayout()
        UIApplication.shared.keyWindow?.insertSubview(self, at: 1)

    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTextData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat(aCellHeight)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aCell:tblCellFloating = tableView.dequeueReusableCell(withIdentifier: "tblCellFloating") as! tblCellFloating
       // aCell.lblCellFloating.textColor  = Color().colorWithHexString(hex: Color.code.ColorO)
        
        //  aCell.lblCellFloating.text = "   " + arrTextData[indexPath.row] + "  ."
        var cellText = ""
        
        aCell.backgroundColor = UIColor.clear
        aCell.selectionStyle = UITableViewCellSelectionStyle.none
        switch arrTextData[indexPath.row] {
        case contentType.checkbox.rawValue:
            cellText =  "Multiple Select"
        case contentType.radio.rawValue:
            cellText =  "Single Select"
        case contentType.datePicker.rawValue:
            cellText =  "Date Picker"
        case contentType.picker.rawValue:
            cellText =  "Picker"
        case contentType.textView.rawValue:
            cellText =  "Text"

        default:
            print("default")
        }
        
        cellText = "   " + cellText + "  ."
        let linkTextWithColor = "."
        
        let range = (cellText as NSString).range(of: linkTextWithColor)
        
        let attributedString = NSMutableAttributedString(string:cellText)
        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white , range: range)
        
        aCell.lblCellFloating.attributedText = attributedString
        aCell.lblCellFloating.tag = indexPath.row
        aCell.imgCellFloating.tag = indexPath.row
        aCell.lblCellFloating.isUserInteractionEnabled = true
        aCell.imgCellFloating.isUserInteractionEnabled = true
        
        var objTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler(sender:)))
        objTapGesture.delegate = self
        aCell.lblCellFloating.addGestureRecognizer(objTapGesture)
        objTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler(sender:)))
        objTapGesture.delegate = self
        aCell.imgCellFloating.addGestureRecognizer(objTapGesture)
        
        aCell.setCornerRadiusOnCategoryLabel()
        aCell.layoutIfNeeded()
        return aCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let cellContentView: UIView? = cell.contentView
        let rotationAngleDegrees: CGFloat = -30
        let rotationAngleRadians: CGFloat = rotationAngleDegrees * (.pi / 180)
        let offsetPositioning = CGPoint(x: 500, y: -20.0)
        var transform: CATransform3D = CATransform3DIdentity
        transform = CATransform3DRotate(transform, rotationAngleRadians, -50.0, 0.0, 1.0)
        transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, -50.0)
        cellContentView?.layer.transform = transform
        cellContentView?.layer.opacity = 0.8
        delayTime -= 0.1
        UIView.animate(withDuration: 0.65, delay:delayTime, usingSpringWithDamping: 0.85, initialSpringVelocity: 0.8, options: [], animations: {() -> Void in
            cellContentView?.layer.transform = CATransform3DIdentity
            cellContentView?.layer.opacity = 1
        }, completion: {(_ finished: Bool) -> Void in
        })
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tblSelectedBlock!(indexPath.row)
//    }
    
    @objc func tapGestureHandler(sender: UITapGestureRecognizer) {
        
        let intTag = sender.view!.tag
        let strValue = arrTextData[intTag]
        tblSelectedBlock!(strValue)
    }
}
