//
//  BluetoothManager.swift
//  PassKitApp
//
//  Created by Migele Beloded on 10/6/14.
//  Copyright (c) 2014 Michael Bielodied. All rights reserved.
//

import Foundation
import CoreBluetooth

protocol BluetoothManagerDelegate
{
    func bluetoothReady()
    func bluetoothError(_ error:String)
}

class BluetoothManager: NSObject, CBCentralManagerDelegate {
    
    private static var __once: () = {
            Static.instance = BluetoothManager()
        }()
    
    fileprivate let cbCentralManager    : CBCentralManager!
    fileprivate var btStatus            : String!
    var delegate                    : BluetoothManagerDelegate?
    
    class var sharedInstance : BluetoothManager {
        
    struct Static {
        static var onceToken : Int = 0
        static var instance : BluetoothManager? = nil
        }
        _ = BluetoothManager.__once
        return Static.instance!
    }
    
    // PRIVATE
    fileprivate override init() {
        super.init()
        self.cbCentralManager = CBCentralManager(delegate:self, queue:nil)
    }
    
    func getBtStatus()->String
    {
        return self.btStatus;
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager!) {
        
        var statusIsOk = false
        
        switch self.cbCentralManager.state {
            
        case .poweredOff:
            print("CoreBluetooth BLE hardware is powered off")
            self.btStatus = "CoreBluetooth BLE hardware is powered off\n"
            break
        case .poweredOn:
            print("CoreBluetooth BLE hardware is powered on and ready")
            self.btStatus = "CoreBluetooth BLE hardware is powered on and ready\n"
            // We can now call scanForBeacons
            statusIsOk = true
            break
        case .resetting:
            print("CoreBluetooth BLE hardware is resetting")
            self.btStatus = "CoreBluetooth BLE hardware is resetting\n"
            break
        case .unauthorized:
            print("CoreBluetooth BLE state is unauthorized")
            self.btStatus = "CoreBluetooth BLE state is unauthorized\n"
            
            break
        case .unknown:
            print("CoreBluetooth BLE state is unknown")
            self.btStatus = "CoreBluetooth BLE state is unknown\n"
            statusIsOk = false
            break
        case .unsupported:
            print("CoreBluetooth BLE hardware is unsupported on this platform")
            self.btStatus = "CoreBluetooth BLE hardware is unsupported on this platform\n"
            break
            
        default:
            break
        }
        
        print("self.bluetoothManager.state = \(self.cbCentralManager.state)");
            
        if statusIsOk {
            delegate?.bluetoothReady()
        }
        else //if btStatus != "unknown"
        {
            delegate?.bluetoothError(btStatus)
        }
    }
}
