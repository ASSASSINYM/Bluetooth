//
//  GATTBatteryLevel.swift
//  Bluetooth
//
//  Created by Alsey Coleman Miller on 6/13/18.
//  Copyright © 2018 PureSwift. All rights reserved.
//

import Foundation

/// Battery Level
///
/// The current charge level of a battery. 100% represents fully charged while 0% represents fully discharged.
///
/// - SeeAlso: [Battery Level](https://www.bluetooth.com/specifications/gatt/viewer?attributeXmlFile=org.bluetooth.characteristic.battery_level.xml)
public struct GATTBatteryLevel: GATTCharacteristic {
    
    public typealias Percentage = GATTPercentage.Byte
    
    internal static let length = 1
    
    public static var uuid: BluetoothUUID { return .batteryLevel }
    
    public var level: Percentage
    
    public init(level: Percentage) {
        
        self.level = level
    }
    
    private init(_ unsafe: Percentage) {
        
        self.level = unsafe
    }
    
    public init?(data: Data) {
        
        guard data.count == type(of: self).length
            else { return nil }
        
        guard let level = Percentage(rawValue: data[0])
            else { return nil }
        
        self.init(level: level)
    }
    
    public var data: Data {
        
        return Data([level.rawValue])
    }
    
    public var characteristic: GATT.Characteristic {
        
        return GATT.Characteristic(uuid: type(of: self).uuid,
                                   value: data,
                                   permissions: [.read],
                                   properties: [.read, .notify],
                                   descriptors: [GATTClientCharacteristicConfiguration().descriptor])
    }
}

extension GATTBatteryLevel: Equatable {
    
    public static func == (lhs: GATTBatteryLevel, rhs: GATTBatteryLevel) -> Bool {
        
        return lhs.level == rhs.level
    }
}

extension GATTBatteryLevel: CustomStringConvertible {
    
    public var description: String {
        
        return "\(level)%"
    }
}

extension GATTBatteryLevel: Hashable {
    
    public var hashValue: Int {
        
        return Int(level.rawValue)
    }
}
