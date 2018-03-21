
import UIKit
import GeniusSportWidgetLoader

final class ViewController: UIViewController {
    var url: URL {
        let urlString = "https://betfred.betstream.betgenius.com/betstream-view/fixturelist/betfredinplay/html"
        return URL(string: urlString)!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let wigetView = GSWidget(url: url, delegate: self)
        
        view = wigetView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: GSWidgetListener {
    func onMessage(type: String, message: [String : Any]) {
        let alertMessage = type == "addToBetslip" ? "Selection added to betslip" : "Selection Removed from betslip"
        showAlert(message: alertMessage)
    }
    
    func onError(type: String, rawMessage: String) {
        print("Type: \(type), message: \(rawMessage)")
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

