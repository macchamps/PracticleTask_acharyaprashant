//
//  MNCollectionViewCell.swift
//  AssignmentAcharyaprashant
//
//  Created by Monang Champaneri on 18/04/24.
//

import UIKit
import Combine

class MNCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    private var cancellable: AnyCancellable?
    
    override func awakeFromNib() {
        self.imgView.image = UIImage(named: "ic_load_placeholder")

    }
    // pass the url of image and handle the memory and cache
    func loadImage(from url: URL) {
            cancellable = ImageLoader.shared.loadImage(from: url).sink { img in
                if img != nil{
                    DispatchQueue.main.async {
                        self.imgView.image = img
                    }
                }else{
                    DispatchQueue.main.async {
                        self.imgView.image = UIImage(named: "ic_failed_placeholder")
                    }
                }
            }
       
       }
    //cancel the past image memory
       override func prepareForReuse() {
           super.prepareForReuse()
           cancellable?.cancel()
           imgView.image = nil
       }
}
