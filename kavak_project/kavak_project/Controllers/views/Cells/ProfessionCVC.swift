//
//  ProfessionCVC.swift
//  kavak_project
//
//  Created by Eduardo Fonseca on 8/5/19.
//  Copyright © 2019 Eduardo Fonseca. All rights reserved.
//

import UIKit

class ProfessionCVC: UICollectionViewCell {
    @IBOutlet weak var professionTitle : UILabel!
    override func awakeFromNib() {
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth  = 1
    }
    
    public func setupWithInfo(profession : String)
    {
        self.professionTitle.text = profession
        
    }
    
}
