//
//  AddButtonView.swift
//  CuraTech
//
//  Created by Bhumika tripathi on 8/11/18.
//  Copyright © 2018 Bhumika tripathi. All rights reserved.
//

import UIKit

class AddButtonView: UIView, UIGestureRecognizerDelegate, UIScrollViewDelegate {
    var controllerForHelp = UIViewController()

    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet var viewParent: UIView!
    
    typealias tblDidSelectCompletionBlock = (_ strValue:String) ->Void
    var tblSelectedBlock : tblDidSelectCompletionBlock?
    
    var atblFloating : tblFloating?
    var arrTextData = [String] ()
    var arrImageData = [String] ()
    var aBtnWidth : Int = 0
    var aBtnFloatingxPos : Int = 0
    var aBtnFloatingyPos : Int = 0
    var aTblCellHeight : Int = 0
    var aAnimationDelay : Double = 0.0
    
    // Initialisation
    
    override init(frame: CGRect) {
        
        let y_Top = (AppConstant.FRAME_HEIGHT - 128);
        
        let viewFrame = CGRect(x: (AppConstant.FRAME_WIDTH - 84), y: y_Top, width: 60, height: 60)
        super.init(frame: viewFrame)
        setUpNib()
        switchThemeForActionButton(isSelected: false)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setUpNib()
    }
    
    func addShadowAndCornerToView()
    {
//        self.layer.cornerRadius = 4.0
//        self.layer.borderWidth = 1.0
//        self.layer.borderColor = UIColor.lightText.cgColor
//        self.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width:5, height: 5)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.8
        self.layer.masksToBounds = false
    }
    
    func setUpNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "AddButtonView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.clipsToBounds = true
        view.layer.cornerRadius = view.frame.size.width / 2
        self.addSubview(view)
        addShadowAndCornerToView()
    }
    
    // MARK:- Floating Table
    
    func setFloatingTable(mainView :UIView, btnWidth: Int, tblCellHeight: Int, btnFloatingxPos:Int , btnFloatingyPos:Int, animationDelay :Double , withCompletionBlock : @escaping tblDidSelectCompletionBlock) {
        tblSelectedBlock = withCompletionBlock
        aBtnFloatingxPos = btnFloatingxPos
        aBtnFloatingyPos = btnFloatingyPos
        aBtnWidth = btnWidth
        aTblCellHeight = tblCellHeight
//        arrTextData = arrText
        aAnimationDelay = animationDelay
        self.backgroundColor = Color().colorWithHexString(hex: NavColor().strColor)
       
    }
    
    // MARK:- Gesture Handler
    
    @objc func tapGestureHandler(recognizer:UITapGestureRecognizer) {
        if atblFloating != nil
        {
            // Theme
            switchThemeForActionButton(isSelected: false)
            // Table
            atblFloating!.removeFromSuperview();
            atblFloating = nil
            return;
        }
    }
    
    // MARK:- Floating button theme
    
    func switchThemeForActionButton(isSelected: Bool)
    {
        viewParent.backgroundColor = Color().colorWithHexString(hex: NavColor().strColor)

        if isSelected {
            btnAdd.setImage(UIImage(named: "ico_close"), for: .normal)
        } else {
            btnAdd.setImage(UIImage(named: "btn_floating_plus"), for: .normal)
        }
    }
    
    // MARK:- Transparent layer
    
    func addTransparentLayer() {
        let aLayerTransparent = CALayer.init()
        aLayerTransparent.frame = controllerForHelp.view.bounds
        aLayerTransparent.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3).cgColor
        controllerForHelp.view.layer.addSublayer(aLayerTransparent)
    }
    
    func removeTransparentLayer() {
        controllerForHelp.view.layer.sublayers?.removeLast()
    }
    
    // MARK:- Actions
    @IBAction func btnAddAction(_ sender: Any) {
        // TODO:- Uncomment
    
        if atblFloating != nil
        {
            // Theme
            switchThemeForActionButton(isSelected: false)
            // Layer
            // Table
            atblFloating?.removeFromSuperview()
            atblFloating = nil
            return
        }
       
        atblFloating = tblFloating()
        // Theme
        switchThemeForActionButton(isSelected: true)
        // Add table
        atblFloating?.addTable(controllerForHelp, strSelectedValue: "", arrText: [contentType.textView.rawValue, contentType.radio.rawValue,contentType.checkbox.rawValue,contentType.datePicker.rawValue,contentType.picker.rawValue,], arrImage: arrImageData, aXpos: 0, aYpos: aBtnFloatingyPos, cellHeight: aTblCellHeight, tblWidth: aBtnFloatingxPos + aBtnWidth, animationDelay: aAnimationDelay, withCompletionBlock: { (strValue) in
            self.switchThemeForActionButton(isSelected: false)

            self.atblFloating!.removeFromSuperview()
            self.atblFloating = nil
            self.tblSelectedBlock!(strValue)
        })
        let objTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler(recognizer:)))
        objTapGesture.delegate = self
        objTapGesture.cancelsTouchesInView = true
        atblFloating!.addGestureRecognizer(objTapGesture)
    }
    
    private func getSubviewsOf<T : UIView>(view:UIView) -> [T] {
        var subviews = [T]()
        
        for subview in view.subviews {
            subviews += getSubviewsOf(view: subview) as [T]
            
            if let subview = subview as? T {
                
                subviews.append(subview)
            }
        }
        
        return subviews
    }
}
