//
//  ViewController.swift
//  checkin
//
//  Created by Henrique Guarnieri on 18/02/2016.
//  Copyright © 2016 Henrique Guarnieri. All rights reserved.
//  Source: http://www.raywenderlich.com/101891/ibeacons-tutorial-ios-swift

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    var myTable: Item!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // DO NOT FORGET TO INSERT DESCRIPTION TEXT FOR LOCATION MANAGER IN Info.plist
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        
        self.myTable = Item(name: "MyTable", uuid: NSUUID(UUIDString: "61687109-905F-4436-91F8-E602F514C96D")!, majorValue: 3, minorValue: 1880)
        startMonitoringItem(self.myTable)
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    func beaconRegionWithItem(item:Item) -> CLBeaconRegion {
        let beaconRegion = CLBeaconRegion(proximityUUID: item.uuid,
            major: item.majorValue,
            minor: item.minorValue,
            identifier: item.name)
        return beaconRegion
    }
    
    func startMonitoringItem(item: Item) {
        let beaconRegion = beaconRegionWithItem(item)
        locationManager.startMonitoringForRegion(beaconRegion)
        locationManager.startRangingBeaconsInRegion(beaconRegion)
        item.registered = true
    }
    
    func stopMonitoringItem(item: Item) {
        let beaconRegion = beaconRegionWithItem(item)
        locationManager.stopMonitoringForRegion(beaconRegion)
        locationManager.stopRangingBeaconsInRegion(beaconRegion)
        item.registered = false
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        
        for beacon in beacons {
            if beacon.proximity == .Immediate && self.myTable.registered {
                self.stopMonitoringItem(self.myTable)
                NSLog("We found your iBeacon!")
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(5 * NSEC_PER_SEC)), dispatch_get_main_queue()) {
                    self.startMonitoringItem(self.myTable)
                    NSLog("iBeacon registered")
                }
            }
        }
        
    }
}