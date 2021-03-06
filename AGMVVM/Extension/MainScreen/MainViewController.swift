//
//  MainViewController.swift
//  AGMVVM
//
//  Created by ahmed gado on 04/08/2021.
//  Copyright © 2021 ahmed gado. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
protocol MainViewProtcool  : AnyObject {
    func showLoading()
    func hideLoading()
    func showError(error : String)
}
class MainViewController: UIViewController {
  
    var  loading : NVActivityIndicatorView = NVActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 70, height: 70), type: .ballBeat, color: UIColor.black, padding: 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loading.center = view.center
        view.addSubview(loading)
    }
    
    func checkIfUserOfIphone() -> Bool {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return true
        }
        else{
            return false
        }
    }
    
    func getMobDevSerial() -> String {
        let strUUID = UIDevice.current.identifierForVendor!.uuidString
        let deviceID = NSString(string: strUUID).substring(from: strUUID.count - 12)
        
        print("deviceID",deviceID)
        return deviceID
    }

   
}

extension MainViewController : MainViewProtcool
{
    func showLoading() {
        view.isUserInteractionEnabled = false
        loading.startAnimating()
    }
    
    func hideLoading() {
        view.isUserInteractionEnabled = true
        loading.stopAnimating()
    }
    
    func showError(error: String) {
        print(error)
    }

}
