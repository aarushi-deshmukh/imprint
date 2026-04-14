import UIKit
import MapKit
import CoreLocation

class Explore: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var sheetY: CGFloat = 0
    var maxY: CGFloat = 0
    let minY: CGFloat = 100 
    var midY: CGFloat = 0
    let feedVC = Memories()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        
        
        addChild(feedVC)
        view.addSubview(feedVC.view)
        let height: CGFloat = 320 // collapsed height
        let safeBottom = view.safeAreaInsets.bottom

        feedVC.view.frame = CGRect(
            x: 0,
            y: view.frame.height - height - safeBottom,
            width: view.frame.width,
            height: view.frame.height
        )
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        feedVC.view.addGestureRecognizer(panGesture)
        feedVC.didMove(toParent: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let safeHeight = view.safeAreaLayoutGuide.layoutFrame.height
        
        maxY = safeHeight - 120
        midY = safeHeight * 0.5
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        let region = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: 20000,
            longitudinalMeters: 20000
        )
        
        mapView.setRegion(region, animated: true)
        let circle = MKCircle(center: location.coordinate, radius: 20000)
        mapView.addOverlay(circle)
        
        locationManager.stopUpdatingLocation()
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let circle = overlay as? MKCircle {
            let renderer = MKCircleRenderer(circle: circle)
            renderer.strokeColor = .blue
            renderer.fillColor = UIColor.blue.withAlphaComponent(0.1)
            renderer.lineWidth = 2
            return renderer
        }
        return MKOverlayRenderer()
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        
        switch gesture.state {
        case .changed:
            var newY = feedVC.view.frame.origin.y + translation.y
            
            // clamp
            newY = max(minY, newY)
            newY = min(maxY, newY)
            
            feedVC.view.frame.origin.y = newY
            gesture.setTranslation(.zero, in: view)
            
        case .ended:
            let velocity = gesture.velocity(in: view).y
            let currentY = feedVC.view.frame.origin.y
            
            if velocity > 500 {
                animateSheet(to: maxY)
            } else if velocity < -500 {
                animateSheet(to: minY)
            } else {
                // snap to nearest
                if currentY < midY {
                    animateSheet(to: minY)
                } else {
                    animateSheet(to: maxY)
                }
            }
        default:
            break
        }
    }
    
    func animateSheet(to y: CGFloat) {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut]) {
            self.feedVC.view.frame.origin.y = y
        }
    }
}
