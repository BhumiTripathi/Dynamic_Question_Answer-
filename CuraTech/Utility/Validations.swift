//
//  Validations.swift
//  CuraTech
//
//  Created by Bhumika tripathi on 8/12/18.
//  Copyright © 2018 Bhumika tripathi. All rights reserved.
//

import Foundation
import UIKit

class CheckValidation
{
    func ValidateTextView(txtView : UITextView) -> Bool
    {
        var boolValidated = false
        let trimmedString = txtView.text.trimmingCharacters(in: .whitespaces)

        if trimmedString != "" && trimmedString.count > 20
        {boolValidated=true}
        
        return boolValidated
    }
}
