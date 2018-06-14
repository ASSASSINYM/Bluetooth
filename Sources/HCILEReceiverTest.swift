//
//  HCILEReceiverTest.swift
//  Bluetooth
//
//  Created by Carlos Duclos on 6/14/18.
//  Copyright © 2018 PureSwift. All rights reserved.
//

import Foundation

/// LE Receiver Test Command
///
/// This command is used to start a test where the DUT receives test reference
/// packets at a fixed interval. The tester generates the test reference packets.
public struct HCILEReceiverTest: HCICommandParameter {
    
    public static let command = HCILowEnergyCommand.receiverTest //0x001D
    
    /// N = (F – 2402) / 2
    /// Range: 0x00 – 0x27. Frequency Range : 2402 MHz to 2480 MHz
    public let rxChannel: LowEnergyRxChannel //RX_Channel
    
    public init(rxChannel: LowEnergyRxChannel) {
        
        self.rxChannel = rxChannel
    }
    
    public var data: Data {
        
        return Data([rxChannel.rawValue])
    }
}
