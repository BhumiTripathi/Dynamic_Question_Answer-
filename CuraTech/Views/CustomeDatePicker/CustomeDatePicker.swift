//
//  CustomeDatePicker.swift
//  CuraTech
//
//  Created by Bhumika tripathi on 8/11/18.
//  Copyright © 2018 Bhumika tripathi. All rights reserved.
//

import UIKit

class CustomeDatePicker: UIView {
    @IBOutlet weak var dateAndTimePicker: UIDatePicker!
    typealias datePickerCompletionBlock = (_ dte:Date) ->Void
    var datePickerBlock : datePickerCompletionBlock?
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
        let nib = UINib(nibName: "CustomeDatePicker", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }
    
    func showDateTimePicker(aDate:Date,aMinumumDate:Date,aLocale:Locale,withCompletionBlock : @escaping datePickerCompletionBlock){
        
        dateAndTimePicker.date = aDate
        dateAndTimePicker.minimumDate = aMinumumDate
        dateAndTimePicker.maximumDate = Date.init()
       // dateAndTimePicker.locale = aLocale
        dateAndTimePicker.addTarget(self, action: #selector(CustomeDatePicker.datePickerValueChanged), for: UIControlEvents.valueChanged)
        datePickerBlock = withCompletionBlock;
        
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        
        //self.datePickerBlock!(sender.date)
    }
    
    
    func showTimePicker(aDate:Date,aLocale:Locale,withCompletionBlock : @escaping datePickerCompletionBlock){
        
        dateAndTimePicker.date = aDate
        dateAndTimePicker.datePickerMode = .time
//        dateAndTimePicker.minimumDate = aMinumumDate
        //dateAndTimePicker.locale = NSLocale(localeIdentifier: "en_GB") as Locale
        dateAndTimePicker.addTarget(self, action: #selector(CustomeDatePicker.datePickerValueChanged), for: UIControlEvents.valueChanged)
        datePickerBlock = withCompletionBlock;
        
    }
    
    @IBAction func btnDoneAction(_ sender: Any) {
        self.datePickerBlock!(dateAndTimePicker.date)

    }
    

}
