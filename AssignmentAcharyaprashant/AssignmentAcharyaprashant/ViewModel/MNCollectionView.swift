//
//  MNCollectionView.swift
//  AssignmentAcharyaprashant
//
//  Created by Monang Champaneri on 18/04/24.
//

import UIKit

class MNCollectionView: UICollectionView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var viewModel:GridViewModel?
    
    override func awakeFromNib() {
        
        self.delegate = self
        self.dataSource = self
        
        self.backgroundColor = .white


    }
    
    func fatchData(){
        self.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel?.gridArray.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? MNCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let url = URL(string: "\(viewModel?.gridArray[indexPath.item].thumbnail.domain ?? "")/\(viewModel?.gridArray[indexPath.item].thumbnail.basePath  ?? "")/0/\(viewModel?.gridArray[indexPath.item].thumbnail.key.rawValue ?? "")")
        {
            cell.loadImage(from:url)
        }
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.bounds.width/3, height: self.bounds.width/3)
    }
    

}
