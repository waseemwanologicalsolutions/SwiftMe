

import UIKit
import GooglePlaces

class SearchPlacesCustomViewController: UIViewController, StoryboardInitializable, UIGestureRecognizerDelegate {
    static func storyboardName() -> String {
        return "Location"
    }
    
    @IBOutlet weak var tableViewList: UITableView!
    
    var tfSearch: UITextField!
    var locations = [AddressModel]()
    var repository = Repository()
    var searchTxt = ""
    var fetcher: GMSAutocompleteFetcher?
    var didPlaceSelected:((AddressModel?)->Void)?
    var parentVcnt:UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
        
        tableViewList.dataSource = self
        tableViewList.delegate = self
        if #available(iOS 15.0, *) {
            tableViewList.sectionHeaderTopPadding = 0
        }
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.handleUndoViewDismissTap(_:)))
        singleTap.cancelsTouchesInView = false
        singleTap.numberOfTapsRequired = 1
        //singleTap.delegate = self
        self.tableViewList.addGestureRecognizer(singleTap)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.tableViewList.reloadData()
        }
        tfSearch.becomeFirstResponder()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
    @objc func handleUndoViewDismissTap(_ recognizer: UITapGestureRecognizer) {
        
        let location = recognizer.location(in: tableViewList)
        if let indexPath = tableViewList.indexPathForRow(at: location){
            if locations.count > indexPath.row{
                self.getPlaceDetails(self.locations[indexPath.row])
            }else{
                self.dismissView()
            }
        }else{
            self.dismissView()
        }
        
    }
    
    func dismissView(_ animated:Bool = false){
        self.tfSearch.endEditing(true)
        self.dismiss(animated: animated, completion: nil)
        self.view.removeFromSuperview()
    }
    func setupBinding(){
        
        //tfSearch.delegate = self
        let filter = GMSAutocompleteFilter()
        let token: GMSAutocompleteSessionToken = GMSAutocompleteSessionToken.init()
        // Create the fetcher.
        fetcher = GMSAutocompleteFetcher(filter: filter)
        
        fetcher?.delegate = self
        fetcher?.provide(token)
        
    }
    
    func searchLocation(_ txt:String){
        /*
         let searchAll = UserSession.getRecentSearches()
         self.recentSearches.removeAll()
         self.recentSearches =  searchAll.filter({($0.title ?? "").lowercased().contains(txt.lowercased()) || ($0.location?.address ?? "").lowercased().contains(txt.lowercased())})
         self.tableViewList.reloadData()
         */
    }
    
    
    @IBAction func nearMePressed(){
        
        //self.perform(#selector(self.showOnScreenLoader), on: Thread.main, with: nil, waitUntilDone: true)
        let latlng = String(LocationsManager.sharedInstance.recentLat) + "," + String(LocationsManager.sharedInstance.recentLng)
        let params = ["latlng": latlng, "key":GOOGLE_KEY.PLACES_KEY, "sensor":"true"]
        self.repository.user.getlatlngToAddress(paramDict: params, api: USER_API_NAME.latlngToAddress) { (result) in
            DispatchQueue.main.async {
                //self.perform(#selector(self.hideOnScreenLoader), on: Thread.main, with: nil, waitUntilDone: true)
                switch result{
                case .failure(let error):
                    print(error.message)
                case .success(let object):
                    let addObj = AddressModel()
                    addObj.address = object.0
                    addObj.name = object.0
                    addObj.country = object.1
                    addObj.city = object.2
                    addObj.lat = LocationsManager.sharedInstance.recentLat
                    addObj.lng = LocationsManager.sharedInstance.recentLng
                    
                }
            }
            
        }
    }
    @IBAction func searchOnMapPressed(){
        
    }
    @IBAction func backPressed(){
        
        let transition = CATransition()
        transition.duration = 0.25
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromTop
        self.navigationController?.view.layer.add(transition, forKey:kCATransition)
        let _ = navigationController?.popViewController(animated: false)
    }
    
    func getPlaceDetails(_ obj:AddressModel){
        //self.perform(#selector(self.showOnScreenLoader), on: Thread.main, with: nil, waitUntilDone: true)
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
                                                  UInt(GMSPlaceField.coordinate.rawValue) |
                                                  UInt(GMSPlaceField.formattedAddress.rawValue) |
                                                  UInt(GMSPlaceField.addressComponents.rawValue) |
                                                  UInt(GMSPlaceField.placeID.rawValue))
        
        let placeClient = GMSPlacesClient.shared()
        placeClient.fetchPlace(fromPlaceID: obj.placeId ?? "", placeFields: fields, sessionToken: nil, callback: {
            (place: GMSPlace?, error: Error?) in
            if let error = error {
                //self.perform(#selector(self.hideOnScreenLoader), on: Thread.main, with: nil, waitUntilDone: true)
                print("An error occurred: \(error.localizedDescription)")
                return
            }
            //self.perform(#selector(self.hideOnScreenLoader), on: Thread.main, with: nil, waitUntilDone: true)
            if let place = place {
                obj.lat = place.coordinate.latitude
                obj.lng = place.coordinate.longitude
                if let allComponets = place.addressComponents{
                    let addCountryCity = AddressModel.getCountryCityName(item: allComponets)
                    obj.country = addCountryCity.0
                    obj.city = addCountryCity.1
                    print(addCountryCity)
                }
                print("The selected place is: \(place)")
                //let vcnt = TripsConCategoryViewController.initFromStoryboard()
                //vcnt.goingToLocation = obj
                //self.navigationController?.pushViewController(vcnt, animated: true)
                //self.addToRecentSearchList(obj)
                
                self.didPlaceSelected?(obj)
                self.dismissView()
            }
        })
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: self.tableViewList) == true {
            return false
        }
        return true
    }
}

extension SearchPlacesCustomViewController:UITableViewDataSource, UITableViewDelegate{
    
    //MARK:- UITableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 0 //recentSearches.count
        }else if section == 1{
            return locations.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = GooglePlaceSearchTableViewCell.dequeue(tableView: tableView)
        let obj = locations[indexPath.row]
        cell.lblTitle.text = obj.name
        cell.lblDetails.text = obj.address
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let obj = locations[indexPath.row]
        self.getPlaceDetails(obj)
        
        
    }
    
    
}

extension SearchPlacesCustomViewController:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute:{
            self.fetcher?.sourceTextHasChanged(textField.text ?? "")
            self.searchLocation(textField.text ?? "")
        })
        
        if string == "\n"{
            return false
        }
        return true
    }
}

extension SearchPlacesCustomViewController: GMSAutocompleteFetcherDelegate {
    func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        self.locations.removeAll()
        for prediction in predictions {
            let obj = AddressModel()
            obj.name = prediction.attributedPrimaryText.string
            obj.address = prediction.attributedSecondaryText?.string ?? prediction.attributedFullText.string
            obj.placeId = prediction.placeID
            self.locations.append(obj)
        }
        print("locations=", self.locations.count)
        self.tableViewList.reloadData()
        if self.locations.isEmpty == true{
            self.view.isHidden = true
        }else{
            self.view.isHidden = false
        }
    }
    
    func didFailAutocompleteWithError(_ error: Error) {
        print(error.localizedDescription)
    }
    
}
