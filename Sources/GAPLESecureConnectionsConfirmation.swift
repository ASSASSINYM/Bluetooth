//
//  GAPLESecureConnectionsConfirmation.swift
//  Bluetooth
//
//  Created by Carlos Duclos on 6/13/18.
//  Copyright © 2018 PureSwift. All rights reserved.
//

import Foundation

/// Specifies the LE Secure Connections Confirmation Value
/// Size: 16 octets
/// Format defined in [Vol 3], Part H, Section 2.3.5.6.4
public struct GAPLESecureConnectionsConfirmation: GAPData, Equatable, Hashable {
    
    public static let dataType: GAPDataType = .lowEnergySecureConnectionsConfirmation
    
    public let confirmation: UInt16
    
    public init(confirmation: UInt16) {
        
        self.confirmation = confirmation
    }
}

public extension GAPLESecureConnectionsConfirmation {
    
    init?(data: Slice<LowEnergyAdvertisingData>) {
        
        guard data.count == 2
            else { return nil }
        
        let confirmation = UInt16(littleEndian: UInt16(bytes: (data[data.startIndex + 0],
                                                               data[data.startIndex + 1])))
        
        self.init(confirmation: confirmation)
    }
    
    func append(to data: inout LowEnergyAdvertisingData) {
        
        data += confirmation.littleEndian
    }
}

// MARK: - ExpressibleByIntegerLiteral

extension GAPLESecureConnectionsConfirmation: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: UInt16) {
        
        self.init(confirmation: value)
    }
}

// MARK: - CustomStringConvertible

extension GAPLESecureConnectionsConfirmation: CustomStringConvertible {
    
    public var description: String {
        
        return confirmation.description
    }
}
