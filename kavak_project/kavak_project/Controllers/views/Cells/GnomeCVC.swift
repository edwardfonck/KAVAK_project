//
//  GnomeCVC.swift
//  kavak_project
//
//  Created by Eduardo Fonseca on 8/5/19.
//  Copyright © 2019 Eduardo Fonseca. All rights reserved.
//

import UIKit

class GnomeCVC: UICollectionViewCell {
    
    @IBOutlet weak var gnomeImage : UIImageView?
    @IBOutlet weak var nameLabel : UILabel?
    @IBOutlet weak var ageLabel : UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureCell()
    }
    
    func configureCell(){
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        gnomeImage?.image = #imageLiteral(resourceName: "placeholder_image")
        gnomeImage?.contentMode = .scaleAspectFill
        gnomeImage?.layer.cornerRadius = 10
        gnomeImage?.layer.masksToBounds = true
    }
    public func setupInfo(gnome: Gnome?, cell: GnomeCVC){
        
        guard let name = gnome?.name , let age = gnome?.age, let thumb = gnome?.thumbnail else { return }
 
        nameLabel?.text =  "\(name)"
        ageLabel?.text = "Age: \(age) years"
        gnomeImage?.cacheImage(imageUrl: thumb, celda: cell)
    }
}
