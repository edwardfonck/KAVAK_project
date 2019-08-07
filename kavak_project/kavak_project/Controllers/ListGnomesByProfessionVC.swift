//
//  ListGnomesByProfessionVC.swift
//  kavak_project
//
//  Created by Eduardo Fonseca on 8/5/19.
//  Copyright © 2019 Eduardo Fonseca. All rights reserved.
//

import UIKit


class ListGnomesByProfessionVC: UIViewController {
    //Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var gnomesCollection: UICollectionView!
    
    //Global variables
    var originalGnomes : [Gnome] = []
    var filteredGnomes : [Gnome] = []
    var SearchingFlag : Bool = false
    
    //Constants
    let reuseIdentifierCell = "gnomeCell"
    private let segueidentifier = "GoToDetailGnome"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureViews()
    }
    
    func configureViews () {
        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem.init()
        self.title = "Gnomes"
        gnomesCollection.register(UINib.init(nibName: "GnomeCVC", bundle: nil), forCellWithReuseIdentifier: reuseIdentifierCell)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == segueidentifier {
            let vc = segue.destination as? GnomeDetailVCViewController
            vc?.selectedGnome = sender as? Gnome
            vc?.allGnomes = originalGnomes
        }
    }
    

}

extension ListGnomesByProfessionVC : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SearchingFlag ? filteredGnomes.count : originalGnomes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifierCell, for: indexPath) as! GnomeCVC
        
        let gnomeObj : Gnome = SearchingFlag ? filteredGnomes[indexPath.row] : originalGnomes[indexPath.row]
        
        cell.setupInfo(gnome: gnomeObj , cell: cell)
        //cell.gnomeImage?.cacheImage(imageUrl: gnomeObj.thumbnail, celda: cell)
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width/2)-20, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedGnome = SearchingFlag ? filteredGnomes[indexPath.row] : originalGnomes[indexPath.row]
        self.performSegue(withIdentifier: segueidentifier, sender: selectedGnome)
    }
    
}

extension ListGnomesByProfessionVC : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}

extension ListGnomesByProfessionVC : UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count == 0 {
            self.SearchingFlag = false
            filteredGnomes.removeAll()
            self.gnomesCollection.reloadData()
            
        } else
            if let text = searchBar.text?.lowercased(),
                let filtered = self.originalGnomes as [Gnome]?,
                !filtered.isEmpty
            {
                self.SearchingFlag = true
                let filteredArray = filtered.filter
                {
                    $0.name.lowercased().contains(text) ||
                        String($0.age).contains(text)  ||
                        $0.hair_color.rawValue.lowercased().contains(text) ||
                        $0.professions?.first(where: { $0.lowercased().contains(text) } ) != nil
                }
                
                filteredGnomes = filteredArray
                self.gnomesCollection.reloadData()
        }
    }
}
