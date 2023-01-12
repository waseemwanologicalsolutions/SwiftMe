//
//  MapLocationSelectionViewController.swift
//  TripCon
//
//  Created by MacBook on 22/12/2021.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapLocationSelectionViewController: UIViewController, StoryboardInitializable {
    static func storyboardName() -> String {
        return "Location"
    }
    
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var viewMap: GMSMapView!
    @IBOutlet weak var viewMapContainer: UIView!
    @IBOutlet weak var lblAddressTitle: UILabel!
    @IBOutlet weak var lblAddressDetails: UILabel!
    
    var locations = [AddressModel]()
    var repository = Repository()
    var lat:Double = 25.2048492
    var lng:Double = 55.2707825
    var lastFoundLat:Double = 0.0
    var lastFoundLng:Double = 0.0
    var selectedAddress:AddressModel = AddressModel()
    var isLocationUpdatedReceived = false
    var isFromHome = false
    var parentVcnt:UIViewController?
    var completeionHandler:((AddressModel?)->Void)?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(locationUpdated), name: NSNotification.Name(rawValue: NOTIFICATIONS.LOCATION_UPDATED), object: nil)
        
        lblAddressTitle.text = "Finding address..."
        lblAddressDetails.text = ""
        lat = Double(LocationsManager.sharedInstance.recentLat)
        lng = Double(LocationsManager.sharedInstance.recentLng)
        selectedAddress.lat = lat
        selectedAddress.lng = lng
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: 18.0)
        self.viewMap.animate(to: camera)
        self.viewMap.isMyLocationEnabled = true
        self.viewMap.settings.myLocationButton = true
        self.viewMap.delegate = self
        LocationsManager.sharedInstance.startGtettingLocation()
        
        DispatchQueue.main.asyncAfter(deadline:.now() + 0.35) {
            self.viewContainer.roundCorners(corners: [.topLeft, .topRight], radius: 25.0)
            self.viewMapContainer.roundCorners(corners: [.topLeft, .topRight], radius: 15.0)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func findDiscoveries(){
        _ = self.completeionHandler?(selectedAddress)
    }
    @IBAction func searchPressed(){
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
                                                  UInt(GMSPlaceField.placeID.rawValue) | UInt(GMSPlaceField.coordinate.rawValue) | UInt(GMSPlaceField.formattedAddress.rawValue))
        autocompleteController.placeFields = fields
        
        // Specify a filter.
        //let filter = GMSAutocompleteFilter()
        //filter.type = .address
        //autocompleteController.autocompleteFilter = filter
        
        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
    }

    @IBAction func backPressed(){
        _ = self.completeionHandler?(nil)
    }
    
    @objc func locationUpdated(){
        if isLocationUpdatedReceived == false{
            isLocationUpdatedReceived = true
            lat = Double(LocationsManager.sharedInstance.recentLat)
            lng = Double(LocationsManager.sharedInstance.recentLng)
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: 18.0)
            self.viewMap.animate(to: camera)
        }
    }
    
}

extension MapLocationSelectionViewController:GMSMapViewDelegate{
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D)  {
        self.view.endEditing(true)
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition)  {
        
        self.view.endEditing(true)
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition)  {
        
        if self.viewMap.tag == -1{
            DispatchQueue.main.asyncAfter(deadline:.now() + 0.5) {
                self.viewMap.tag = 0
            }
            return
        }
        let point:CGPoint = mapView.center
        //point.x = UIScreen.main.bounds.size.width/2
        //point.y = (UIScreen.main.bounds.size.height - 68)/2
        
        let coor:CLLocationCoordinate2D = mapView.projection.coordinate(for: point)
        let coordinate₀ = CLLocation(latitude: self.lastFoundLat, longitude: self.lastFoundLng)
        let coordinate₁ = CLLocation(latitude: coor.latitude, longitude:coor.longitude)
        let distanceInMeters = coordinate₀.distance(from: coordinate₁)
        selectedAddress.lat = coor.latitude
        selectedAddress.lng = coor.longitude
        if(distanceInMeters > 20){
            self.lastFoundLat = coor.latitude
            self.lastFoundLng = coor.longitude
            let latlng = String(coor.latitude) + "," + String(coor.longitude)
            let params = ["latlng": latlng, "key":GOOGLE_KEY.PLACES_KEY, "sensor":"true"]
            self.repository.user.getlatlngToAddress(paramDict: params, api: USER_API_NAME.latlngToAddress) { (result) in
                DispatchQueue.main.async {
                    switch result{
                    case .failure(let error):
                        print(error.message)
                    case .success(let object):
                        print(object)
                        self.selectedAddress.address = object.0
                        self.selectedAddress.country = object.1
                        self.selectedAddress.city = object.2
                        self.selectedAddress.name = object.0
                        self.lblAddressDetails.text = object.0
                        var comps = [String]()
                        if object.2.isEmpty == false{
                            comps.append(object.2)
                        }
                        if object.1.isEmpty == false{
                            comps.append(object.1)
                        }
                        self.lblAddressTitle.text = comps.joined(separator: ", ")
                    }
                }
                
            }
            
        }
        
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        return false
    }
    
}

extension MapLocationSelectionViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        print("Place name: \(String(describing: place.name))")
        print("Place ID: \(String(describing: place.placeID))")
        print("lat: \(String(place.coordinate.latitude))")
        dismiss(animated: true, completion: nil)
        
        self.viewMap.tag = -1
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: self.viewMap.camera.zoom)
        self.viewMap.animate(to: camera)
        self.selectedAddress = AddressModel()
        self.selectedAddress.name = place.name ?? ""
        self.selectedAddress.address = place.formattedAddress ?? ""
        self.selectedAddress.lat = place.coordinate.latitude
        self.selectedAddress.lng = place.coordinate.longitude
        self.lblAddressTitle.text = self.selectedAddress.name
        self.lblAddressDetails.text = self.selectedAddress.address
        
        let latlng = String(place.coordinate.latitude) + "," + String(place.coordinate.longitude)
        let params = ["latlng": latlng, "key":GOOGLE_KEY.PLACES_KEY, "sensor":"true"]
        self.repository.user.getlatlngToAddress(paramDict: params, api: USER_API_NAME.latlngToAddress) { (result) in
            DispatchQueue.main.async {
                switch result{
                case .failure(let error):
                    print(error.message)
                case .success(let object):
                    print(object)
                    self.selectedAddress.address = object.0
                    self.selectedAddress.country = object.1
                    self.selectedAddress.city = object.2
                    self.selectedAddress.name = object.0
                    self.lblAddressDetails.text = object.0
                    var comps = [String]()
                    if object.2.isEmpty == false{
                        comps.append(object.2)
                    }
                    if object.1.isEmpty == false{
                        comps.append(object.1)
                    }
                    self.lblAddressTitle.text = comps.joined(separator: ", ")
                }
            }
            
        }
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
