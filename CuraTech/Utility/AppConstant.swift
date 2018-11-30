//
//  AppDelegate.swift
//  CuraTech
//
//  Created by Bhumika tripathi on 8/11/18.
//  Copyright © 2018 Bhumika tripathi. All rights reserved.
//

import Foundation
import UIKit
let FRAME_WIDTH         = UIScreen.main.bounds.size.width
let FRAME_HEIGHT        = UIScreen.main.bounds.size.height

struct AppConstant {
    
    //ScreenSize
    static let FRAME_WIDTH         = UIScreen.main.bounds.size.width
    static let FRAME_HEIGHT        = UIScreen.main.bounds.size.height
    static var FRAME_MAX_LENGTH : CGFloat {
        get{ return max(AppConstant.FRAME_WIDTH, FRAME_HEIGHT) }
    }
    
    static var FRAME_MIN_LENGTH : CGFloat {
        get{ return min(AppConstant.FRAME_WIDTH, FRAME_HEIGHT) }
    }
    
    
    //DeviceType
    static var IS_IPHONE_4_OR_LESS : Bool {
        get{ return UIDevice.current.userInterfaceIdiom == .phone && AppConstant.FRAME_MAX_LENGTH < 568.0 }
    }
    static var IS_IPHONE_5 : Bool {
        get{ return UIDevice.current.userInterfaceIdiom == .phone && AppConstant.FRAME_MAX_LENGTH == 568.0}
    }
    static var IS_IPHONE_6 : Bool {
        get{ return UIDevice.current.userInterfaceIdiom == .phone && AppConstant.FRAME_MAX_LENGTH == 667.0 }
    }
    static var IS_IPHONE_6P : Bool {
        get{ return UIDevice.current.userInterfaceIdiom == .phone && AppConstant.FRAME_MAX_LENGTH == 736.0}
    }
    static var IS_IPHONE_X : Bool {
        get{ return UIDevice.current.userInterfaceIdiom == .phone && AppConstant.FRAME_MAX_LENGTH == 812.0}
    }
    static var IS_IPAD_AIR : Bool {
        get{ return UIDevice.current.userInterfaceIdiom == .pad && AppConstant.FRAME_MAX_LENGTH == 1024.0}
    }
    static var IS_IPAD_PRO : Bool {
        get{ return UIDevice.current.userInterfaceIdiom == .pad && AppConstant.FRAME_MAX_LENGTH == 1366.0}
    }
    
    
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad
    
    static let IS_IPHONE            = UIDevice.current.userInterfaceIdiom == .phone
    
    static let IS_LANDSCAPE         = UIApplication.shared.statusBarOrientation == .landscapeLeft ||
        UIApplication.shared.statusBarOrientation == .landscapeRight
    
    static let IS_POTRAIT           = UIApplication.shared.statusBarOrientation == .portrait
    
    static let cardSpacing : CGFloat = 32.0
    
    

}



