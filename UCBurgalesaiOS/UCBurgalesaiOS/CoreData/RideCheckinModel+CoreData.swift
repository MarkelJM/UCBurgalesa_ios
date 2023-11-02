//
//  CheckinStatus.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 2/11/23.
//

import Foundation
import CoreData

@objc(RideCheckin)
public class RideCheckin: NSManagedObject {
    @NSManaged public var rideId: String
    @NSManaged public var hasStarted: Bool
    @NSManaged public var hasCompleted: Bool
    @NSManaged public var checkinDate: Date
}
