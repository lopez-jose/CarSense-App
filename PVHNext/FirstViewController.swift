//
//  FirstViewController.swift
//  PVHNext

//  Created by Jose on 1/24/20.
//  Copyright © 2020 PVH. All rights reserved.
//

import UIKit
import Parse
import MapKit
import UserNotifications

/* The first view controller is the controller for the Current Conditions screen. The user interacts with this layer when the application is first run. Here the user sees the curren conditions of the car as well as current warning levels */

class FirstViewController: UIViewController {
    /*These are labels for the input/output object
     mapView        > used to store a map object
     result         > used to store the input from the C to F button
     progressView   > used to store progressView for F
     btn            > used to store emergency response
     level          > used to store Warning Level #
     warningText    > used to store Warning Level text
     HI             > used to store Humidity Index
     humidity       > used to store humidity
     dateresult     > used to store date
     image          > used to store CarSense
     CO             > used to store CO
     progressHumidity > used to store progress bar for humidity
     progressCO     > used to store progress bar for CO
     warningOn      > used to store the warning label*/
    
@IBOutlet private var mapView: MKMapView!
@IBOutlet private var result: UILabel!
@IBOutlet weak var progressView: UIProgressView!
@IBOutlet private var level: UILabel!
@IBOutlet private var warningText:UILabel!
@IBOutlet private var HI: UILabel!
@IBOutlet private var humidity: UILabel!
@IBOutlet private var dateresult:UILabel!
@IBOutlet var image: UIImageView!
@IBOutlet private var CO: UILabel!
@IBOutlet weak var progressHumidity: UIProgressView!
@IBOutlet weak var progressCO: UIProgressView!
@IBOutlet private var warningOn:UILabel!
    
    

    //The Variables necessary are pulled from AppDelegate.
    
    var temp = AppDelegate.shared().temperature
    var humid = AppDelegate.shared().y
    var mode = AppDelegate.shared().Mode
    var COPPM = AppDelegate.shared().COPPM
    var realAdjusted = 0;
    var realStored = 0;
    var lat = AppDelegate.shared().lat;
    var long = AppDelegate.shared().long;
    
    //Segmented Control for MkMapView on Current Conditions Screen
    
  @IBAction func segmentedControlAction(sender: UISegmentedControl!) {
      switch (sender.selectedSegmentIndex) {
          case 0:
              mapView.mapType = .standard
          case 1:
              mapView.mapType = .satellite
            case 2:
        mapView.mapType = .hybridFlyover
          default:
              mapView.mapType = .hybrid
      }
  }
    //Fahrenheit to Celsius conversion for outputted temperature and progressBar
    @IBAction func segmentedControlAction2(sender: UISegmentedControl!) {
         switch (sender.selectedSegmentIndex) {
             case 0:
                   temp = AppDelegate.shared().temperature
                  print(temp);
                 result.text = String(temp)
                   realAdjusted=realStored;
                                         HI.text = String(realAdjusted)
                   
                let alert = UIAlertController(title: "Units Changed", message: "Changed to Fahrenheit, F°", preferredStyle: .alert)
                           alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                           NSLog("The \"OK\" alert occured.")
                           }))
                           self.present(alert, animated: true, completion: nil)
             
             case 1:
                 temp = Int((5/9)*Float(temp-32));
                  print(temp);
                 result.text = String(temp)
                 realAdjusted=Int((5/9)*Float(realAdjusted-32));
                 HI.text = String(realAdjusted)
               
            let alert = UIAlertController(title: "Units Changed", message: "Changed to Celsius, C°", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
                      
              
             default:
                 mapView.mapType = .hybrid
         }
     }
 

    @IBAction func taskTwo(sender: UIButton) {
       progressView.progressTintColor=UIColor.blue
           }
    override func viewDidLoad() {
        
           super.viewDidLoad()
        let temp = AppDelegate.shared().temperature
        let initialLocation = CLLocation(latitude: lat, longitude:  long)
           mapView.centerToLocation(initialLocation)
        
    
      
        // Show artwork on map
        let artwork = Artwork(
          title: "Toyota Corolla",
          locationName: "CarSense ID: PVH232",
          discipline: "CarSense",
          coordinate: CLLocationCoordinate2D(latitude: lat, longitude:  long))
        mapView.addAnnotation(artwork)
        
        //Logo for the CarSense application visibile in CurrentConditions Scene
        image.image = UIImage(named: "SDPlogo1.png")
        
        
        //Text printout out of felttemp, humidity, co
        result.text = String(temp)
        humidity.text = String(humid)
        CO.text = String(COPPM);
        
        
        
        //adjustments to values given certain conditions
        if(humid>40 && temp>100)
        {
            realAdjusted = temp+(humid/8)+(humid/4);
        }
        
        else if(humid>80 && temp>90)
        {
            realAdjusted = temp+(humid/3);
        }else{
            realAdjusted = temp+(humid/10);
        }
        
        
        //This section is for adjusting values to conform to a progress bar
        var value = Float(realAdjusted)/120
        var humidityDecimal = Float(humid)/100
        var CODecimal = Float(COPPM)/100
        
        
        //Sets the initial progres of progress bar from current conditions
        progressView.setProgress(value, animated: true)
        progressHumidity.setProgress(humidityDecimal, animated: true)
        progressCO.setProgress(CODecimal, animated:true)
        
        
        //Scales progress bars to be more visible
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 5)
        progressHumidity.transform = progressHumidity.transform.scaledBy(x: 1, y: 5)
        progressCO.transform = progressCO.transform.scaledBy(x: 1, y: 5)
        
        
        //Setting of progress bar colors given current levels.
        if(progressHumidity.progress>0.7)
        {
            progressHumidity.progressTintColor=UIColor.red
        }else{
            progressHumidity.progressTintColor=UIColor.green
        }
        if(progressView.progress>0.583)
        {
            progressView.progressTintColor=UIColor.red
        }else{
            progressView.progressTintColor=UIColor.green
        }
        
        if(progressCO.progress>0.7)
        {
            progressCO.progressTintColor=UIColor.red
        }else{
            progressCO.progressTintColor=UIColor.green
        }
        
        
        realStored = realAdjusted;
        HI.text = String(realAdjusted)
        
        //Warning Level 4 Printout to Current Conditions Screen
        if(realAdjusted>105 || COPPM > 149) {
            level.text = String(4)
            warningText.text = "4: There is a child present in the vehicle. Emergency Services are on the way. Door is now open."
             warningOn.text = "Warning Level";
        }
            //Warning Level 3 Printout to Current Conditions Screen
        else if(realAdjusted>91 || COPPM>70)
        {
            level.text = String(3)
            warningText.text = "3: There is a child present in the vehicle. Emergency Services are being contacted. The car is now unlocked and the car alarm is on."
            warningOn.text = "Warning Level";
        }
            //Warning Level 2 Printout to Current Conditions Screen
        else if(realAdjusted>86 || COPPM > 70)
        {
                  level.text = String(2)
             warningText.text = "2: There is a child present in the vehicle, the car windows will be rolled down. "
            warningOn.text = "Warning Level";
        }
            //Warning Level 1 Printout to Current Conditions Screen
        else if(realAdjusted>80){
            level.text=String(1)
            warningText.text = "1: There is a child present in the vehicle."
            warningOn.text = "Warning Level";
            
          
        }
            //Printout to Current Conditions Screen
        else{
            level.text=""
            warningText.text = ""
            warningOn.text = "";
        }
     
        
        //Declaration of Date Object in order to timestamp eventt
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        
        let datetime = formatter.string(from: date)
   
        //Printing current date to Current Conditions Screen.
        dateresult.text = datetime
       
       }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


//extension of the mapview object in order to set region to a given bound surrounding an object.
private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
//Mapview annotation
func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard annotation is MKPointAnnotation else { return nil }

    let identifier = "Annotation"
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

    if annotationView == nil {
        annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        annotationView!.canShowCallout = true
    } else {
        annotationView!.annotation = annotation
    }

    return annotationView
}

    

  








