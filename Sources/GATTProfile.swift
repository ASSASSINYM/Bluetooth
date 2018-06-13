//
//  GATTProfile.swift
//  Bluetooth-macOS
//
//  Created by Carlos Duclos on 6/4/18.
//  Copyright © 2018 PureSwift. All rights reserved.
//

import Foundation

protocol GATTProfile {
    
    static var services: [GATTProfileService.Type] { get }
}

public protocol GATTProfileService {
    
    static var uuid: BluetoothUUID { get }
}

public protocol GATTProfileCharacteristic {
    
    static var uuid: BluetoothUUID { get }
    
    init?(data: Data)
    
    var data: Data { get }
    
    var characteristic: GATT.Characteristic { get }
}

extension GATTProfileCharacteristic {
    
    public var characteristic: GATT.Characteristic {
        
        return GATT.Characteristic(uuid: type(of: self).uuid,
                                   value: data,
                                   permissions: [.read],
                                   properties: [.read],
                                   descriptors: [])
    }
    
}
