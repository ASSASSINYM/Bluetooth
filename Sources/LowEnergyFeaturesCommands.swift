//
//  LowEnergyFeaturesCommands.swift
//  Bluetooth
//
//  Created by Alsey Coleman Miller on 4/10/18.
//  Copyright © 2018 PureSwift. All rights reserved.
//

public extension BluetoothHostControllerInterface {
    
    /// LE Read Local Supported Features Command
    ///
    /// This command requests the list of the supported LE features for the Controller.
    func readLocalSupportedFeatures(timeout: HCICommandTimeout = .default) throws -> LowEnergyFeatureSet {
        
        let returValue = try deviceRequest(HCILowEnergyCommand.HCILEReadLocalSupportedFeaturesReturn.self, timeout: timeout)
        
        return returValue.features
    }
    
    /// LE Read Supported States
    ///
    /// The LE_Read_Supported_States command reads the states and state combinations that the link layer supports.
    func readSupportedStates(timeout: HCICommandTimeout = .default) throws -> LowEnergyStateSet {
        
        let returValue = try deviceRequest(HCILowEnergyCommand.ReadSupportedStatesReturnParameter.self, timeout: timeout)
        
        return returValue.state
    }
    
    /// LE Read Transmit Power Command
    ///
    /// The command is used to read the minimum and maximum transmit powers supported by the Controller.ReadTransmitPowerReturnParameter
    func lowEnergyReadTransmitPower(timeout: HCICommandTimeout = .default) throws -> HCILowEnergyCommand.ReadTransmitPowerReturnParameter {
        
        return try deviceRequest(HCILowEnergyCommand.ReadTransmitPowerReturnParameter.self, timeout: timeout)
    }
    
    /// LE Read RF Path Compensation Command
    ///
    /// The command is used to read the RF Path Compensation Values parameter used in the Tx Power Level and RSSI calculation.
    func lowEnergyReadRfPathCompensation(timeout: HCICommandTimeout = .default) throws -> HCILowEnergyCommand.ReadRfPathCompensationReturnParameter {
        
        return try deviceRequest(HCILowEnergyCommand.ReadRfPathCompensationReturnParameter.self, timeout: timeout)
    }
    
}
