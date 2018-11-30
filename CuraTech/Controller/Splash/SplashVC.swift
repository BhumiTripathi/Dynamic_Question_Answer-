//
//  SplashVC.swift
//  CuraTech
//
//  Created by Bhumika tripathi on 8/12/18.
//  Copyright © 2018 Bhumika tripathi. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {

    @IBOutlet var img_splash_image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        img_splash_image.layer.cornerRadius = 75.0
    }

    override func viewDidAppear(_ animated: Bool) {
        
        img_splash_image.frame = CGRect.init(x: FRAME_WIDTH/2-75, y: FRAME_HEIGHT, width: 150, height: 150)
        UIView.animate(withDuration: 1.5, animations: {
            self.img_splash_image.frame = CGRect.init(x: FRAME_WIDTH/2-75, y: FRAME_HEIGHT/2-100, width: 150, height: 150)
        }, completion: { (value:Bool) in
            let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "QuestionsVC") as! QuestionsVC
            self.navigationController?.pushViewController(homeVC, animated: false)
        })
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
