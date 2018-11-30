//
//  CustomClassPickerView.swift
//  CuraTech
//
//  Created by Bhumika tripathi on 8/11/18.
//  Copyright © 2018 Bhumika tripathi. All rights reserved.
//
import UIKit

class GlobalPickerView: UIView, UIPickerViewDelegate , UIPickerViewDataSource {
    
    @IBOutlet weak var viewPicker: UIPickerView!
    @IBOutlet weak var btnDone: UIButton!
    
    typealias pickerCompletionBlock = (_ strValue: String,_ strDone: String) ->Void
    var pickerBlock : pickerCompletionBlock?
    var arrData = [String]()
    var intRowIndex = 0
    var button = UIButton()
    
    struct setUpView { var pickerViewBackgroundColor: UIColor = UIColor.white }
    
    var aSetUpView = setUpView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(
            self,
            selector:  #selector(deviceDidRotate),
            name: .UIDeviceOrientationDidChange,
            object: nil
        )
    }
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
        let nib = UINib(nibName: "GlobalPickerView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        btnDone.setTitle("Done", for: UIControlState.normal)
        self.addSubview(view)
    }
    //MARK: -->Button action
    
    @IBAction func btnDoneAction(_ sender: Any) {
        if intRowIndex < arrData.count
        {
            self.pickerBlock!(arrData[intRowIndex] as String, "Done")
        }
    }
    @IBAction func btnCancelClick(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.frame.origin.y = UIScreen.main.bounds.height
        }, completion: { (finished) in
            self.removeDatePicker()
        })
    }
    
    //MARK: ---> Delegates methods of picker view
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40.0 }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrData[row] }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if row < arrData.count
        {
            //self.pickerBlock!(arrData[row] as String, "")
        }
        intRowIndex = row
    }
    
    //MARK: ---> Datasource methods of picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return arrData.count
    }
    
    //MARK: -- >Other Methods
    
    //Method to show picker
    @objc func showPicker( strSelectedIndex : String, array : [String] , withCompletionBlock : @escaping pickerCompletionBlock) {
        arrData = [String]()
        arrData = array
        pickerBlock = withCompletionBlock
        viewPicker.reloadAllComponents()
        if let row = (arrData).index(of: strSelectedIndex) {
            intRowIndex = row
            viewPicker.selectRow(row, inComponent:  0, animated: false)
        }
    }
    
    //Remove picker
    func removeDatePicker(){
        self.removeFromSuperview()
        self.button.removeFromSuperview()
    }
    
    //Function to check device is rotated or not
    @objc func deviceDidRotate() {
        if(UIDeviceOrientationIsLandscape(UIDevice.current.orientation)){
            setframe(setHeight: 216)
        }
        if(UIDeviceOrientationIsPortrait(UIDevice.current.orientation)){
            setframe(setHeight: 260)
        }
    }
    
    //Set frame when device is rotated
    func setframe(setHeight:CGFloat) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = CGRect(x: 0, y:UIScreen.main.bounds.height-setHeight, width:UIScreen.main.bounds.width, height:setHeight)
            self.layoutIfNeeded()
            
        })
    }

}
