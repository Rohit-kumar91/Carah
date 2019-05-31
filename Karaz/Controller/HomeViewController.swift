//
//  HomeViewController.swift
//  Karaz
//
//  Created by Rohit Kumar on 28/05/19.
//  Copyright © 2019 Rohit Kumar. All rights reserved.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController {

    
    @IBOutlet weak var collectionView: CollectionViewX!
    
    var voucherData = [JSON]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getCategory()
    }

    @IBAction func menuButtonAction(_ sender: UIButton) {
        sideMenuController?.revealMenu()
       
    }
    
    
    func getCategory() {
        ServiceHelper.sharedInstance.createGetRequest(isShowHud: true, apiName: GET_CATEGORIES) { (response, error) in
            if error != nil {
                AlertController.alert(title: API_FAIL, message: (error?.description)!)
                return
            }
            
            if (response != nil) {
                let jsonResponse = JSON(response as Any)
                print(jsonResponse)
                
                if jsonResponse["success"].boolValue {
                    //Success
                    Singleton.instance.categoryData = jsonResponse["data"].arrayValue
                    self.getVouchers(voucherId: "15")
                   
                } else {
                    AlertController.alert(title: API_FAIL, message: jsonResponse["error"].stringValue)
                }
            }
        }
    }
    
    
    func getVouchers(voucherId: String) {
        ServiceHelper.sharedInstance.createGetRequest(isShowHud: true, apiName: VOUCHERS + voucherId) { (response, error) in
            if error != nil {
                AlertController.alert(title: API_FAIL, message: (error?.description)!)
                return
            }
            
            if (response != nil) {
                let jsonResponse = JSON(response as Any)
                print("VC-c",jsonResponse)
                
                if jsonResponse["success"].boolValue {
                    //Success
                    self.voucherData = jsonResponse["data"]["content"].arrayValue
                     self.collectionView.reloadData()
                    
                } else {
                    AlertController.alert(title: API_FAIL, message: jsonResponse["error"].stringValue)
                }
            }
        }
    }
    
}


extension HomeViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return voucherData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VoucherCollectionViewCell
        cell.voucherName.text = voucherData[indexPath.row]["title"]["en"].stringValue
        cell.voucherPrice.text = voucherData[indexPath.row]["price"].stringValue
        cell.addToCart.tag = indexPath.row
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  55
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2.1)
    }
}
