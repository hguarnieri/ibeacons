//
//  ItemModel.swift
//  checkin
//
//  Created by Henrique Guarnieri on 18/02/2016.
//  Copyright © 2016 Henrique Guarnieri. All rights reserved.
//  Source: http://www.raywenderlich.com/101891/ibeacons-tutorial-ios-swift

import Foundation
import CoreLocation

class Item {
    
    let name: String
    let uuid: NSUUID
    let majorValue: CLBeaconMajorValue
    let minorValue: CLBeaconMinorValue
    var registered: Bool
    
    init(name: String, uuid: NSUUID, majorValue: CLBeaconMinorValue, minorValue: CLBeaconMinorValue) {
        self.name = name
        self.uuid = uuid
        self.majorValue = majorValue
        self.minorValue = minorValue
        self.registered = false
    }
    
}

func ==(item: Item, beacon: CLBeacon) -> Bool {
    return ((beacon.proximityUUID.UUIDString == item.uuid.UUIDString)
        && (Int(beacon.major) == Int(item.majorValue))
        && (Int(beacon.minor) == Int(item.minorValue)))
}