//
//  HomePresenter.swift
//  CarAssignment
//
//  Created by Engy Hussein on 7/10/18.
//  Copyright © 2018 Engy Hussein. All rights reserved.
//

import UIKit
import ObjectMapper

protocol HomePresenterProtocol: NSObjectProtocol {}

class HomePresenter: NSObject, HomePresenterProtocol {
    
    //MARK-: properties
    weak var delegate: HomeViewProtocol?
    var timer: Timer?
    
    //MARK-: presenter init
    init(withView view: HomeViewProtocol) {
        super.init()
        self.delegate = view
        self.getListUpdates()
    }
    
    //MARK- helping methods
    
    // this method to get all list updates
    @objc func getListUpdates() {
        self.delegate?.startAnimating()
        var ticks : String = "0"
        if let latestTicks = UserDefaults.standard.object(forKey: kLatestRecievedTicks) as? String  {
            ticks = latestTicks
        }
        let params = ["ticks": ticks ]
        let request = CarsServices.getCars(params: params)
        NetworkManager.request(request: request) { [weak self] result in
            self?.delegate?.stopAnimating()
            switch result {
            case .success(let data):
                if let  dataResult = Mapper<ResultsModel>().map(JSONObject: data) {
                    if let latestTicks = dataResult.ticks as? String {
                        UserDefaults.standard.set(latestTicks, forKey: kLatestRecievedTicks)
                        UserDefaults.standard.synchronize()
                    }
                    if let refreshInterval = dataResult.refreshInterval as? Int {
                        UserDefaults.standard.set(refreshInterval, forKey: kRefreshInterval)
                        UserDefaults.standard.synchronize()
                    }
                    if let list = dataResult.cars as? [CarModel] {
                        self?.delegate?.setupViewWith(list: list)
                    }
                    self?.setTimer()
                }
                else    
                {
                    self?.delegate?.setupViewWith(list: [])
                }
            case .failure(let error):
                self?.delegate?.setupForError(error: error.localizedDescription)
            }
        }
    }
    
    
    // handle refresh list after the previous setted time interval
    func setTimer() {
        self.removeTimer()
        guard let refreshInterval = UserDefaults.standard.object(forKey: kRefreshInterval) as? Int else {
            return
        }
        self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(refreshInterval), target: self, selector: #selector(getListUpdates), userInfo: nil, repeats: false)
    }
    
    func removeTimer() {
        if self.timer != nil {
            timer?.invalidate()
        }
    }
    
}
