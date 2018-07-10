//
//  CarTableViewCell.swift
//  CarAssignment
//
//  Created by Engy Hussein on 7/10/18.
//  Copyright © 2018 Engy Hussein. All rights reserved.
//

import UIKit
import Foundation
import CountdownLabel

class CarTableViewCell: UITableViewCell {
    
    //MARK-: view outlets
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var isFavImage: UIImageView!
    
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var carPriceLabel: UILabel!
    @IBOutlet weak var carCurrencyLabel: UILabel!
    @IBOutlet weak var kLotLabel: UILabel!
    @IBOutlet weak var lotLabel: UILabel!
    @IBOutlet weak var kBidsLabel: UILabel!
    @IBOutlet weak var bidsLabel: UILabel!
    @IBOutlet weak var kTimeLeftLabel: UILabel!
    @IBOutlet weak var timeLeftLabel: CountdownLabel!
    
    //MARK-: view properties
    let cellCornerRadius : CGFloat = 8.0
    let kTimeThreshould : Double = 300.0
    
    //MARK-: view Load
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCellView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    //MARK-: view setup
    func setupCellView() {
        self.setupLocalization()
        self.containerView.layer.cornerRadius = self.cellCornerRadius
    }
    
    func setupLocalization() {
        self.kLotLabel.text = "lot.label".localizedString
        self.kBidsLabel.text = "bids.label".localizedString
        self.kTimeLeftLabel.text = "time.left.label".localizedString
    }
    
    func setupCellFor(car: CarModel) {
        self.carNameLabel.text = car.carName
        self.carPriceLabel.text = "\(car.auction.currentPrice)"
        self.carCurrencyLabel.text = car.auction.currency
        self.lotLabel.text = "\(car.auction.lot)"
        self.bidsLabel.text = "\(car.auction.bid)"
        self.carImage.image = #imageLiteral(resourceName: "ic-default")
        self.setCarImageWith(url: car.image)
        self.prepareCountDownWith(mins:  Double(car.auction.endDate))
    }
    
    func setCarImageWith(url: String) {
        // to handle lazy loading for images in cell
        if let url = self.prepareImageURL(url: url) as? String {
            self.carImage.downloadImageFrom(link: self.prepareImageURL(url: url), contentMode: .scaleAspectFill)
        }
    }
    
    func prepareImageURL(url: String)-> String {
        if let widthURL = url.replacingOccurrences(of: "[w]", with: "\(self.carImage.frame.width)") as? String {            if let imageURL = widthURL.replacingOccurrences(of: "[h]", with: "\(self.carImage.frame.height)") as? String {
                return imageURL
            }
        }
        return ""
    }
    
    func prepareCountDownWith(mins: Double) {
        self.timeLeftLabel.textColor = .black
        if mins < kTimeThreshould {
            self.timeLeftLabel.textColor = .red
        }
        timeLeftLabel.setCountDownTime(minutes: mins)
        timeLeftLabel.start()
        timeLeftLabel.then(targetTime: kTimeThreshould, completion: {
            self.timeLeftLabel.textColor = .red
        })
    }
    

}
