//
//  RideCheckin+CoreDataProperties.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 2/11/23.
//

import Foundation
import CoreData

extension RideCheckin {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<RideCheckin> {
        return NSFetchRequest<RideCheckin>(entityName: "RideCheckin")
    }
    
    
    
    

}

//video 2 o 3 minuto 2:45:19 si usamos identificadores necesitamos extensione de RideCheckin : identifiable {}
extension RideCheckin: Identifiable {
    public var id: String {
        return rideId
    }
}
