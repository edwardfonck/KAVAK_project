//
//  ViewController.swift
//  kavak_project
//
//  Created by Eduardo Fonseca on 8/4/19.
//  Copyright © 2019 Eduardo Fonseca. All rights reserved.
//

import UIKit
//Global variables
let refreshControl = UIRefreshControl()
var isRefreshing = false
var brastlewarkonObj : [Gnome] = []
var professionArr : [String] = []

//Constants
let headerReuseIdentifier = "Header"
let footerReuseIdentifier = "Footer"
let reuseIdentifier = "ProfessionCell"
let headerTitle = "Pick a desire profession"
private let segueIdentifier = "goToGnomes"

class ProfessionsVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var professions_Collection : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configurateCollection()
        getAllInfoFromService()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        professions_Collection.delegate = self
        professions_Collection.dataSource = self
    }
    
    func configurateCollection () {
        
        
        
//Header register
self.professions_Collection!.register(UINib.init(nibName: "ProfessionHeaderCRV", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
        professions_Collection.addSubview(refreshControl)
    }
    
    func pullToRefresh () {
        professions_Collection.setContentOffset(CGPoint.init(x: 0, y: -refreshControl.frame.height), animated: true)
        refreshControl.beginRefreshing()
    }
    
    func getAllInfoFromService(){
        pullToRefresh()
        Services.callServiceBrastlewarkon(Success: { (Response) in
            DispatchQueue.main.async {
                refreshControl.endRefreshing()
            }
            
            debugPrint("Success")
            brastlewarkonObj = Response
            professionArr = Array(self.filterAllProfessions(Brastlewarkon_response: brastlewarkonObj).ValueAsSet)
            
            DispatchQueue.main.async {
                self.professions_Collection.reloadData()
            }
            
        }) { (Error) in
            DispatchQueue.main.async {
                refreshControl.endRefreshing()
            }
            debugPrint("Error")
        }
        
    }
    
    func filterAllProfessions (Brastlewarkon_response : [Gnome]) -> [String]{
        var professions : [String] = []
        for tempProfessions in Brastlewarkon_response {
            if let tempProfessions = tempProfessions.professions{
                for profession in tempProfessions {
                    professions.append(profession)
                }
            }
        }
        return professions
    }
    
    func arrayOfGnomesBySelectedProfession(selectedProf : String) -> [Gnome] {
        var arrGnomesByProf : [Gnome] = []
        
        for obj in brastlewarkonObj.self {
            if let profession :[String] = obj.professions
            {
                if profession.contains(selectedProf)
                {
                    arrGnomesByProf.append(obj)
                }
            }
        }
        return arrGnomesByProf
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            let vc = segue.destination as? ListGnomesByProfessionVC
            vc?.originalGnomes = sender as! [Gnome] 
        }
    }
    
}

extension ProfessionsVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return professionArr.count > 0 ? professionArr.count: 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProfessionCVC
        
        if professionArr.ValueAsSet.count > 0 {
            let arr = Array(professionArr.ValueAsSet)
            cell.setupWithInfo(profession: arr[indexPath.item])
        }
        
        return cell
    }
    
    private func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
   
//        switch kind {
//
//        case UICollectionView.elementKindSectionHeader:
        
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifier, for: indexPath as IndexPath) as! ProfessionHeaderCRV
            
            
            headerView.headerTitle.text = headerTitle
            headerView.headerTitle.textColor = .blue
            headerView.layer.cornerRadius = 10
            headerView.layer.borderWidth = 2
            headerView.layer.borderColor = UIColor.blue.cgColor
            return headerView

//        default:
//            assert(false, "Unexpected element kind")
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-20, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        return CGSize(width: collectionView.frame.width-20, height: 50)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: segueIdentifier, sender: arrayOfGnomesBySelectedProfession(selectedProf: professionArr[indexPath.item]))
    }
}




