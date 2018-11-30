//
//  AppDelegate.swift
//  CuraTech
//
//  Created by Bhumika tripathi on 8/11/18.
//  Copyright © 2018 Bhumika tripathi. All rights reserved.
//

import UIKit

struct NavColor
{
    //941751
    var strColor : String = "#138993"
}
@objc class ViewNavBar: UIView {
    
    @IBOutlet weak var viewNavBar: UIView!
    @IBOutlet weak var lblNavTitle: UILabel!
    @IBOutlet weak var btnNavLeft: UIButton!
    @IBOutlet var imgNavRight: UIImageView!
    @IBOutlet var imgNavLeft: UIImageView!
    @IBOutlet var btnNavRight: UIButton!
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setUpNib()
    }
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setUpNib()
    }
    
    func setUpNib() {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ViewNavBar", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        lblNavTitle.font = UIFont(name: "Georgia", size: AppConstant.IS_IPAD ? 25 : 20)!

        
    }
    typealias viewNavBlock = (_ selectedKey : String)-> Void
    var navBlock : viewNavBlock?
    var strRight :String = ""
    @objc  public func setNavBar(strTitle:String,btnLeft:Bool,sourceController:UIViewController, btnImgName:String, completionBlock :@escaping viewNavBlock)  {
    sourceController.navigationController?.isNavigationBarHidden = true
        navBlock = completionBlock
        var navBarHeight : CGFloat = 64
        if UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2436 {
            
            navBarHeight = 88
        }
        
        self.frame = CGRect(x: 0, y:0, width:AppConstant.FRAME_WIDTH, height:navBarHeight)
        sourceController.view.addSubview(self)
        lblNavTitle.text = strTitle
      //  btnNavLeft.setImage(UIImage(named: "back"), for: .normal)
        btnNavLeft.isHidden = false
        imgNavLeft.image = UIImage(named: "back")
        if !btnLeft{
            btnNavLeft.isHidden = true
            imgNavLeft.isHidden = true
        }
        
        self.backgroundColor = Color().colorWithHexString(hex: NavColor().strColor)
        self.lblNavTitle.backgroundColor = Color().colorWithHexString(hex: NavColor().strColor)
        
    }
    
    @IBAction func btnRightAction(_ sender: Any) {
        navBlock!("Right")
    }
    @IBAction func btnLeftAction(_ sender: Any) {
        navBlock!("back")
    }
    
}
