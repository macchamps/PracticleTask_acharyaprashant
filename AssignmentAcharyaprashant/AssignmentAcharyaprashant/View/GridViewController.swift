//
//  GridViewController.swift
//  AssignmentAcharyaprashant
//
//  Created by Monang Champaneri on 18/04/24.
//

import UIKit
protocol GridViewControllerDelegate {
    func fatchSuccessData()
    func fatchDataError(message:String)
}


class GridViewController: UIViewController {
    
    let activityIndicator = UIActivityIndicatorView(style: .large)

    @IBOutlet weak var clnView: MNCollectionView!
    
    var viewModel:GridViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLoader()
        viewModel = GridViewModel()
        clnView.viewModel  = viewModel
        viewModel?.delegate = self
        
        self.fatchData()
        
    }
    func setupLoader(){
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.isHidden = true
    }
    
    func fatchData(){
        self.showLoader()
        DispatchQueue.global().async {
            self.viewModel?.fatchData()
        }
    }

    func showLoader(){
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
    }
    func hideLoader(){
        DispatchQueue.main.sync {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
        
    }

}
extension GridViewController:GridViewControllerDelegate{
    
    func fatchSuccessData() {
        self.hideLoader()
        DispatchQueue.main.sync {
            clnView.fatchData()
        }
    }
    
    func fatchDataError(message: String) {
        self.hideLoader()
    }
    
    
}

