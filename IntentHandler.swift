//
//  IntentHandler.swift
//  Extension
//
//  Created by Joshua Hudson on 4/9/17.
//  Copyright © 2017 ParanoidPenguinProductions. All rights reserved.
//

import Intents
import UIKit

class INIntentHandler: INExtension, INRidesharingDomainHandling {
    
    // Method gets called when the user requests a list of ride options
    func handle(listRideOptions intent: INListRideOptionsIntent, completion: @escaping (INListRideOptionsIntentResponse) -> Void) {
        
        let result = INListRideOptionsIntentResponse(code: .success, userActivity: nil)
        
        //List out available ride option. Currently hardcoded with time to delivery.
        let mini = INRideOption(name: "Mini Cooper", estimatedPickupDate: Date(timeIntervalSinceNow: 1000))
        let accord = INRideOption(name: "Honda Accord", estimatedPickupDate: Date(timeIntervalSinceNow: 800))
        let ferrari = INRideOption(name: "Ferrari F430", estimatedPickupDate: Date(timeIntervalSinceNow: 300))
        ferrari.disclaimerMessage = "You pay for what you get!"
        
        result.expirationDate = Date(timeIntervalSinceNow: 3600)
        
        //Build the array of available rides
        result.rideOptions = [mini, accord, ferrari]
        
        completion(result)
        
    }
    
    func handle(requestRide intent: INRequestRideIntent, completion: @escaping (INRequestRideIntentResponse) -> Void) {
        
        let result = INRequestRideIntentResponse(code: .success, userActivity: nil)
        
        let status = INRideStatus()
        
        // Identify the ride via our internal value
        status.rideIdentifier = "abc123"
        
        // Pass through the pickup and drop off locations
        status.pickupLocation = intent.pickupLocation
        status.dropOffLocation = intent.dropOffLocation
        
        // Confirm the ride
        status.phase = INRidePhase.confirmed
        
        // Give a time of pickup. Hard coded at 15 min.
        status.estimatedPickupDate = Date(timeIntervalSinceNow: 900)
        
        // Create and configure vehicle
        let vehicle = INRideVehicle()
        
        // Load the car image into UIImage, convert to PNG data, then create an INImage from the data
        let image = UIImage(named: "car")!
        let data = UIImagePNGRepresentation(image)!
        vehicle.mapAnnotationImage = INImage(imageData: data)
        
        vehicle.location = intent.dropOffLocation!.location
        
        result.rideStatus = status
        
        completion(result)
        
    }
    
    // Method gets called when user queries the location of the vehicle picking them up. Requires server support
    func handle(getRideStatus intent: INGetRideStatusIntent, completion: @escaping (INGetRideStatusIntentResponse) -> Void) {
        
        let result = INGetRideStatusIntentResponse(code: .success, userActivity: nil)
        completion(result)
        
    }
    
    func startSendingUpdates(forGetRideStatus intent: INGetRideStatusIntent, to observer: INGetRideStatusIntentResponseObserver) {
        
        
        
    }
    
    func stopSendingUpdates(forGetRideStatus intent: INGetRideStatusIntent) {
        
        
        
    }
    
    func resolvePickupLocation(forRequestRide intent: INRequestRideIntent, with completion: @escaping (INPlacemarkResolutionResult) -> Void) {
        
        let result: INPlacemarkResolutionResult
        
        if let requestedLocation = intent.pickupLocation {
            
            // Valid pickup location - return success
            result = INPlacemarkResolutionResult.success(with: requestedLocation)
            
        } else {
            
            // No valid pickup location
            result = INPlacemarkResolutionResult.needsValue()
            
        }
        completion(result)
        
    }
    
    func resolveDropOffLocation(forRequestRide intent: INRequestRideIntent, with completion: @escaping (INPlacemarkResolutionResult) -> Void) {
        
        let result: INPlacemarkResolutionResult
        
        if let requestedLocation = intent.dropOffLocation {
            
            // Valid dropoff location - return success
            result = INPlacemarkResolutionResult.success(with: requestedLocation)
            
        } else {
            
            // No valid dropoff location
            result = INPlacemarkResolutionResult.needsValue()
            
        }
        completion(result)
        
    }
    
}





























