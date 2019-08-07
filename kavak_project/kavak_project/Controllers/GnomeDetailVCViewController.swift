//
//  GnomeDetailVCViewController.swift
//  kavak_project
//
//  Created by Eduardo Fonseca on 8/6/19.
//  Copyright © 2019 Eduardo Fonseca. All rights reserved.
//

import UIKit


class GnomeDetailVCViewController: UIViewController, MXParallaxHeaderDelegate {
    
    //Properties
    var selectedGnome : Gnome?
    var allGnomes : [Gnome]?
    @IBOutlet weak var view_header : UIView!
    @IBOutlet weak var image_header : UIImageView!
    //Constants
    private let gnomeCellReuseIdentifier = "gnomeDetailCell"
    private let reuseIdentifierCellCol = "gnomeCell"
    
    //Outlets
    @IBOutlet weak var tbGnomeDetail : UITableView!
    @IBOutlet weak var cvGnomeDetail : UICollectionView!
    @IBOutlet weak var gnomeNameLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureViews()
        registerUINibs()
    }
    
    fileprivate func configureViews () {
        
        gnomeNameLabel.text = "Unknown gnome"
        self.image_header.image = #imageLiteral(resourceName: "placeholder_image")
        
        if let gnomeName = selectedGnome?.name , let imgUrl = selectedGnome?.thumbnail {
            
            gnomeNameLabel.text = gnomeName
            self.image_header.cacheImage(imageUrl:imgUrl )
        }
        
        
        tbGnomeDetail.parallaxHeader.view = self.view_header
        tbGnomeDetail.parallaxHeader.delegate = self;
        tbGnomeDetail.parallaxHeader.height = 150
        tbGnomeDetail.parallaxHeader.mode = MXParallaxHeaderMode.fill
        tbGnomeDetail.parallaxHeader.minimumHeight = 50
    }
    
    func registerUINibs(){
        cvGnomeDetail.register(UINib.init(nibName: "GnomeCVC", bundle: nil), forCellWithReuseIdentifier: reuseIdentifierCellCol)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension GnomeDetailVCViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: gnomeCellReuseIdentifier, for: indexPath) as! GnomeDetailTVC
        
        guard let age = selectedGnome?.age, let weight = selectedGnome?.weight, let height = selectedGnome?.height else { return UITableViewCell.init() }
        
        if let hair : Hair_Color = selectedGnome?.hair_color
        {
            switch hair {
            case .BLACK: cell.hairColor_label.text = "BLACK"
                        cell.hairColor_label.backgroundColor = .black
                        cell.hairColor_label.textColor = .white
            case .PINK: cell.hairColor_label.text =  "PINK"
                        cell.hairColor_label.backgroundColor = UIColor.init(red: 254/255, green: 127/255, blue: 156/255, alpha: 1.0)
            case .GREEN: cell.hairColor_label.text =  "GREEN"
                cell.hairColor_label.backgroundColor = .green
            case .RED: cell.hairColor_label.text =  "RED"
                cell.hairColor_label.backgroundColor = .red
            case .GRAY: cell.hairColor_label.text =  "GRAY"
                cell.hairColor_label.backgroundColor = .gray
            }
        }
        else
        {
            cell.hairColor_label.text = "Unknown_Color"
        }
        
        
        cell.age_label.text = String(age) + " years"
        cell.weight_label.text  = String(format: "%.2f''", weight)
        cell.height_label.text  = String(format: "%.2f''", height)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tbGnomeDetail.frame.height - 150
    }
}

extension GnomeDetailVCViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let friends = selectedGnome?.friends else { return 0 }
        guard let gnomeFriends = filterGnomesByFriends(friends: friends), gnomeFriends.count > 0 else {
            return friends.count
        }
        return gnomeFriends.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifierCellCol, for: indexPath) as! GnomeCVC
        
        
        guard let friends = selectedGnome?.friends, friends.count > 0 else { return cell }
       
        let gnomeFriends = filterGnomesByFriends(friends: friends)
        
        if let gnomeFriends = gnomeFriends, gnomeFriends.count > 0 {
        
        cell.nameLabel?.text =  "\(gnomeFriends[indexPath.row].name)"
        cell.ageLabel?.text = "Age: \(gnomeFriends[indexPath.row].age) years"
        cell.gnomeImage?.cacheImage(imageUrl: gnomeFriends[indexPath.row].thumbnail)
        }else
        {
            cell.nameLabel?.text =  "\(friends[indexPath.row])"
            cell.ageLabel?.text = "Age: ? years"
            //cell.gnomeImage?.cacheImage(imageUrl: "")
        }
        
        return cell
    }
    
    func filterGnomesByFriends (friends : [String]) -> [Gnome]?{
        
        var completeArray : [Gnome]? = []
        guard let gnomesList = allGnomes else { return [] }
        
        for nameGnome : String in friends {
        let filteredArray = gnomesList.filter
        {
            $0.name == nameGnome
        }
            for obj in filteredArray {
        completeArray?.append(obj)
            }
        }
        return completeArray!.count > 0 ? completeArray! : []
    }
    
}
