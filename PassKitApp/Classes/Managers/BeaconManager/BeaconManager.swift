//
//  BeaconManager.swift
//  PassKitApp
//
//  Created by Migele Beloded on 10/6/14.
//  Copyright (c) 2014 Michael Bielodied. All rights reserved.
//

import Foundation
protocol BeaconManagerDelegate
{

}

class BeaconManager: NSObject, BluetoothManagerDelegate, CLLocationManagerDelegate {
    
    static let sharedInstance = BeaconManager()
    
    fileprivate let proximityUUID = UUID(uuidString:"19D5F76A-FD04-5AA3-B16E-E93277163AF6")
    fileprivate let locationManager     : CLLocationManager!
    fileprivate var beaconRegion        : CLBeaconRegion!
    fileprivate var btStatus            : String!
    fileprivate var delegate            : BeaconManagerDelegate?
    fileprivate var isBeaconAchieved    : Bool
    
    // PRIVATE
    override init() {
        
        self.isBeaconAchieved = false;
        
        super.init()
        
        locationManager = CLLocationManager()
        
    }
    
    func start()
    {
        beaconRegion = CLBeaconRegion(proximityUUID:proximityUUID!,identifier:"GemTot USB")
        
        BluetoothManager.sharedInstance.delegate = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
//LocationManager Delegate
    func locationManager(_ manager: CLLocationManager!, didStartMonitoringFor region: CLRegion!) {
        manager.requestState(for: region)
        print("Scanning...")
    }
    
    func locationManager(_ manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
        print("locations = \(locations)")
    }
    
    func locationManager(_ manager: CLLocationManager!, didEnterRegion region:CLRegion!) {
        if region.isKind(of: CLBeaconRegion.self)
        {
            print("HI")
            AlertManager.sharedInstance.showAlert("iBeacon", msg: "HI", delegate: nil, btn: "Ok")
        }
    }
    
    func locationManager(_ manager: CLLocationManager!, didExitRegion region:CLRegion!) {
        if region.isKind(of: CLBeaconRegion.self)
        {
            if self.isBeaconAchieved {
                self.isBeaconAchieved = false
                print("GOOD_BYE")
                AlertManager.sharedInstance.showAlert("iBeacon", msg: "GOOD_BYE", delegate: nil, btn: "Ok")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager!, monitoringDidFailFor region: CLRegion!, withError error: Error) {
//        NSLog(@"Failed monitoring region: %@", error);
//        [alertManager showAlert:@"Failed monitoring region" errorMsg:error.description];
        print("Failed monitoring region: \(error)")
    }

    func locationManager(_ manager: CLLocationManager!, didFailWithError error:Error) {
        print("Location manager failed: \(error)");
//        [alertManager showAlert:@"Location manager failed: " errorMsg:error.description];
    }

    func locationManager(_ manager: CLLocationManager!, didRangeBeacons beacons:NSArray!, inRegion region:CLBeaconRegion!)
    {

        print(beacons)
        
        if(beacons.count == 0) { return }

        var beacon = beacons[0] as! CLBeacon
        
        /*
        beacon
        proximityUUID   :   region name
        major           :   id１
        minor           :   id２
        proximity       :   provim
        accuracy        :   acc
        rssi            :   rssi
        */
        if (beacon.proximity == CLProximity.unknown) {
            print("Unknown Proximity")
//            reset()
            return
        } else if (beacon.proximity == CLProximity.immediate) {
            print("Immediate")
        } else if (beacon.proximity == CLProximity.near) {
            print("Near")
        } else if (beacon.proximity == CLProximity.far) {
            print("Far")
        }
    }
    
    func locationManager(_ manager: CLLocationManager!, didDetermineState state: CLRegionState, inRegion: CLBeaconRegion!)
    {
        if (state == .inside) {
            manager.startRangingBeacons(in: inRegion)
            AlertManager.sharedInstance.showAlert("beacon info", msg: "You are inside of beacon range", delegate: nil, btn: "Ok")
        }

//        // Scan our registered notifications to see if this state change
//        // has a user message associated with it
//        NSString * stateStr = @"";
//        
//        switch (state) {
//        case CLRegionStateUnknown:
//        {
//        [manager stopRangingBeaconsInRegion:(CLBeaconRegion*)region];
//        stateStr = @"unknown";
//        break;
//        }
//        case CLRegionStateInside:
//        {
//        [manager startRangingBeaconsInRegion:(CLBeaconRegion*)region];
//        stateStr = @"You are inside of beacon range";
//        break;
//        }
//        case CLRegionStateOutside:
//        {
//        [manager stopRangingBeaconsInRegion:(CLBeaconRegion*)region];
//        stateStr = @"You are outside of beacon range";
//        if(isBeaconAchieved) {
//        isBeaconAchieved = NO;
//        [self.startViewController hideAll];
//        }
//        break;
//        
//        default:
//        break;
//        }
//        }
//        [self.startViewController.rangeStatus setText:stateStr];
    
    }
    
    func startMonitoringItem(/*item: BeaconModel*/)
    {
    
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:

            self.locationManager.startRangingBeacons(in: self.beaconRegion)
        case .notDetermined:
            AlertManager.sharedInstance.showAlert("iBeacon", msg: "RStarting Monitor", delegate: nil, btn: "Ok")
//            if(UIDevice.currentDevice().systemVersion.substringToIndex(1).toInt() >= 8){
//
//                self.locationManager.requestAlwaysAuthorization()
//            }else{
//                self.locationManager.startRangingBeaconsInRegion(self.beaconRegion)
//            }
        case .restricted, .denied:

            print("Restricted")
            AlertManager.sharedInstance.showAlert("iBeacon", msg: "Restricted Monitor", delegate: nil, btn: "Ok")
        }
    
    }
    
    func stopMonitoringItem()
    {

    }
    
//Bluetooth Delegate
    func bluetoothReady()
    {
        print("Start of beacons scanning")
//        AlertManager.sharedInstance.showAlert("Bluetooth", msg: "Start of beacons scanning", delegate: nil, btn: "Ok")
        startMonitoringItem()
    }
    
    func bluetoothError(_ error:String)
    {
        print("Error: \(error)")
//        AlertManager.sharedInstance.showAlert("Bluetooth", msg: "Error: \(error)", delegate: nil, btn: "Ok")
        stopMonitoringItem()
    }
    
}
