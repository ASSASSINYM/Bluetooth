//
//  LowEnergyPhyCommands.swift
//  Bluetooth
//
//  Created by Marco Estrella on 4/7/18.
//  Copyright © 2018 PureSwift. All rights reserved.
//

public extension BluetoothHostControllerInterface {
    
    /// LE Read PHY Command
    ///
    /// This ommand is used to read the current transmitter PHY and receiver PHY
    /// on the connection identified by the Connection_Handle.
    func lowEnergyReadPhy(connectionHandle: UInt16, timeout: HCICommandTimeout = .default) throws -> HCILowEnergyCommand.ReadPHYReturnParameter {
        
        let parameters = HCILowEnergyCommand.HCILEReadPHY(connectionHandle: connectionHandle)
        
        let value = try deviceRequest(parameters, HCILowEnergyCommand.ReadPHYReturnParameter.self, timeout: timeout)
        
        return value
    }
    
    /// LE Set Default PHY Command
    ///
    /// The command allows the Host to specify its preferred values for the transmitter PHY
    /// and receiver PHY to be used for all subsequent connections over the LE transport.
    func lowEnergySetDefaultPhy(allPhys: LowEnergyAllPhys,
                                txPhys: LowEnergyTxPhys,
                                rxPhys: LowEnergyRxPhys,
                                timeout: HCICommandTimeout = .default) throws {
        
        let parameters = HCILowEnergyCommand.HCILESetDefaultPhy(allPhys: allPhys, txPhys: txPhys, rxPhys: rxPhys)
        
        try deviceRequest(parameters, timeout: timeout)
    }
    
    /// LE Set PHY Command
    ///
    /// command is used to set the PHY preferences for the connection identified by
    /// the Connection_Handle. The Controller might not be able to make the change
    /// (e.g. because the peer does not support the requested PHY) or may decide that
    /// the current PHY is preferable.
    func lowEnergySetPhyParameter(connectionHandle: UInt16,
                                  allPhys: LowEnergyAllPhys,
                                  txPhys: LowEnergyTxPhys,
                                  rxPhys: LowEnergyRxPhys,
                                  phyOptions: LowEnergyPhyOptions,
                                  timeout: HCICommandTimeout = .default) throws -> LowEnergyEvent.PhyUpdateCompleteEventParameter {
        
        let parameters = HCILowEnergyCommand.HCILESetPhy(connectionHandle: connectionHandle,
                                                          allPhys: allPhys,
                                                          txPhys: txPhys,
                                                          rxPhys: rxPhys,
                                                          phyOptions: phyOptions)
        
        let event =  try deviceRequest(parameters,
                                       LowEnergyEvent.PhyUpdateCompleteEventParameter.self,
                                       timeout: timeout)
        
        switch event.status {
            
        case let .error(error):
            throw error
            
        case .success:
            return event
        }
    }
}
