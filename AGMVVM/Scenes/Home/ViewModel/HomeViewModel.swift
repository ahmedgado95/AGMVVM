//
//  HomeViewModel.swift
//  AGMVVM
//
//  Created by ahmed gado on 03/08/2021.
//  Copyright © 2021 ahmed gado. All rights reserved.
//

import Foundation

class HomeViewModel  {
    var reloadData : (()->())?

    private  weak var delegate : MainViewProtcool?
    private var homeSource : [HomeItem] = [] {
        didSet{
            self.reloadData?()
        }
    }
  

    init(delegate : MainViewProtcool) {
        self.delegate = delegate
        getData()
    }
    
    func getData (){
        delegate?.showLoading()
        NetworkManager.gethomeDetails.send(HomeModel.self){ [weak self](response) in
            guard let self = self else{return}
            self.delegate?.hideLoading()
            switch response{
            case .success(let value):
                self.homeSource = value.data
                
            case .failure(let error):
                
                guard let errorMessage = error as? APIError else {
                    // server Error
                    print(error.localizedDescription)
                    return
                }
                // BackEnd Error
                self.delegate?.showError(error: errorMessage.localizedDescription)
                
            }
        }
    }
    
    func getHomeDetailsCount() -> Int {
        return homeSource.count
    }
   

    
    func configerCell (cell : HomeDetailsCellView , index : Int){
        let item = homeSource[index]
        cell.displayData(price: " Salary : \(item.employeeSalary)", name: " Name : \(item.employeeName)", number: " Number : \(item.id)")
    }
    
    func didSelectRow(index: Int) {
        let item = homeSource[index]
        print(item.employeeName)
       }
}
