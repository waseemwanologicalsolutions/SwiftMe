//
//  LocationsManager.swift

import Foundation
import GoogleMaps
import CoreLocation

class LocationsManager: NSObject, CLLocationManagerDelegate {
    
    var locationManager:CLLocationManager!
    var location:CLLocation!
    var recentLat:Double = 0.0
    var recentLng:Double = 0.0
    var completionHandlerRegionFound:((String)->Void)?
    var completionHandlerLocationFound:((Double, Double)->Void)?
    
    override init() {
        super.init()
    }
    
    static let sharedInstance: LocationsManager = {
        let instance = LocationsManager()
        // setup code
        return instance
    }()
    
    // MARK: - Initialization Method
    
    
    func startGtettingLocation() {
        
        location = CLLocation(latitude: 0, longitude: 0)
        if(self.locationManager == nil){
            self.locationManager = CLLocationManager()
        }
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.pausesLocationUpdatesAutomatically = false
        self.locationManager.distanceFilter = 50
        self.locationManager.requestWhenInUseAuthorization()
        //self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
    
    }
    
    func stopGtettingLocation() {
        
        if(self.locationManager != nil){
            self.locationManager.stopUpdatingLocation()
        }
        
    }
    
    //MARK:- Location Manager delegates
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        self.location = location
        if LocationsManager.distanceBetweenLocation(lat: location?.coordinate.latitude ?? 0, lng: location?.coordinate.longitude ?? 0, lat2: self.recentLat, lng2: self.recentLng) > 0.005 || self.recentLng == 0{
            self.recentLat = (location?.coordinate.latitude)!
            self.recentLng = (location?.coordinate.longitude)!
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NOTIFICATIONS_LOCATION_UPDATED"), object: nil)
            _ = self.completionHandlerLocationFound?(self.recentLat, self.recentLng)
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print("error=",error.localizedDescription)
    }
    
    class func isLocationServiceEnabled()->Bool{
        
        let enable:Bool = CLLocationManager.locationServicesEnabled()
        let auth = CLLocationManager.authorizationStatus()
        if(!enable || auth == .notDetermined || auth == .restricted || auth == .denied || CLLocationManager.locationServicesEnabled() == false){
            return false
        }
        else{
            return true
        }
        
    }
    
    class func distanceFromCurrentLocationTo(lat:Double, lng:Double) -> Double{
        
        let locA = CLLocation(latitude: CLLocationDegrees(LocationsManager.sharedInstance.recentLat), longitude: CLLocationDegrees(LocationsManager.sharedInstance.recentLng))
        let locB = CLLocation(latitude: lat, longitude: lng)
        let distance = locA.distance(from: locB)
        let kmDistance = distance/1000.0
        //print("kmDistance=",kmDistance)
        return kmDistance
    }
    
    class func distanceBetweenLocation(lat:Double, lng:Double, lat2:Double, lng2:Double) -> Double{
        
        let locA = CLLocation(latitude: CLLocationDegrees(lat2), longitude: CLLocationDegrees(lng2))
        let locB = CLLocation(latitude: lat, longitude: lng)
        let distance = locA.distance(from: locB)
        let kmDistance = distance/1000.0
        //print("kmDistance=",kmDistance)
        return kmDistance
    }
    
    func monitorRegionAtLocation(center: CLLocationCoordinate2D, identifier: String ) {
        // Make sure the app is authorized.
        // Make sure region monitoring is supported.
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            // Register the region.
            let maxDistance = 50.0
            let region = CLCircularRegion(center: center,
                                          radius: maxDistance, identifier: identifier)
            region.notifyOnEntry = true
            region.notifyOnExit = false

            locationManager.startMonitoring(for: region)
            print("monitorRegionAtLocation=",identifier)
        }
    }
    
    func getPolyline(startLocation: CLLocationCoordinate2D, endLocation: CLLocationCoordinate2D) -> GMSPolyline? {
        //Create initial path
        let path = GMSMutablePath()
        
        //STEP 1:
        let SE = GMSGeometryDistance(startLocation, endLocation)
        
        //STEP 2:
        let angle = Double.pi / 2

        //STEP 3:
        let ME = SE / 2.0
        let R = ME / sin(angle / 2)
        let MO = R * cos(angle / 2)
        
        //STEP 4:
        let heading = GMSGeometryHeading(startLocation, endLocation)
        let mCoordinate = GMSGeometryOffset(startLocation, ME, heading)
        let direction = (startLocation.longitude - endLocation.longitude > 0) ? -1.0 : 1.0
        let angleFromCenter = 90.0 * direction
        let oCoordinate = GMSGeometryOffset(mCoordinate, MO, heading + angleFromCenter)
        
        //Add endLocation to the path
        path.add(endLocation)
        
        
        //STEP 5:
        let num = 100
        
        let initialHeading = GMSGeometryHeading(oCoordinate, endLocation)
        let degree = (180.0 * angle) / Double.pi
        
        for i in 1...num {
            let step = Double(i) * (degree / Double(num))
            let heading : Double = (-1.0) * direction
            let pointOnCurvedLine = GMSGeometryOffset(oCoordinate, R, initialHeading + heading * step)
            path.add(pointOnCurvedLine)
        }
        
        path.add(startLocation)
       
        //STEP 6:
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 4.0
        polyline.strokeColor = UIColor.black
        
        return polyline
    }
    
}

extension LocationsManager{
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if let region = region as? CLCircularRegion {
            let identifier = region.identifier
            print("FOUND: " + identifier)
            _ = self.completionHandlerRegionFound?(region.identifier)
        }
    }

}

