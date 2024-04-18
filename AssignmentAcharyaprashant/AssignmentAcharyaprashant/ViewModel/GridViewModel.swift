//
//  GridViewModel.swift
//  AssignmentAcharyaprashant
//
//  Created by Monang Champaneri on 18/04/24.
//

import UIKit

class GridViewModel: NSObject {
    
    var gridArray:[GridModel] = []
    
    var delegate:GridViewControllerDelegate?
    
    override init() {
        
    }
    
    func fatchData(){
        let apiUrl = URL(string: Constant().base_url + Constant().api_url)!

               // Create a URLSession task to fetch the data
               URLSession.shared.dataTask(with: apiUrl) { [weak self] data, response, error in
                   guard let weakSelf = self else{
                           return
                       }
                   guard let data = data, error == nil else {
                       print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                           weakSelf.delegate?.fatchDataError(message: error?.localizedDescription ?? "Unknown error" )
                       return
                   }
                
                   do {
                       // Deserialize JSON data into a Swift object
                       let decoder = JSONDecoder()
                       let gridData = try decoder.decode([GridModel].self, from: data)
                       
                       weakSelf.gridArray = gridData
                       weakSelf.delegate?.fatchSuccessData()
                       
                   } catch {
                       print("Error deserializing JSON: \(error)")
                       weakSelf.delegate?.fatchDataError(message: error.localizedDescription )
                   }
               }.resume()
    }
}

