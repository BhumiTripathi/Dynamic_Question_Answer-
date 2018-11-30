//
//  AddQuestion.swift
//  CuraTech
//
//  Created by Bhumika tripathi on 8/12/18.
//  Copyright © 2018 Bhumika tripathi. All rights reserved.
//

import Foundation

class AddQuestionTest
{
    
    func testQuestionType(type : String)
    {
        switch type {
        case contentType.checkbox.rawValue:
            print("accepted")
        case contentType.radio.rawValue:
            print("accepted")
        case contentType.text.rawValue:
            print("accepted")
        case contentType.textView.rawValue:
            print("accepted")
        case contentType.datePicker.rawValue:
            print("accepted")
        case contentType.picker.rawValue:
            print("accepted")
        default:
            print("data type not supported.")
        }
    }
    
}
