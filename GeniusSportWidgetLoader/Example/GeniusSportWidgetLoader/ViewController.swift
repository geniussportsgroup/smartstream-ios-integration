
import UIKit
import GeniusSportWidgetLoader

class ViewController: UIViewController {
    var url: URL {
        let urlString = "https://betfred.betstream.betgenius.com/betstream-view/fixturelist/betfredinplay/html"
        return URL(string: urlString)!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let wigetView = GSWiget(url: url, delegate: self)
        
        view = wigetView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: GSWidgetListener {
    func onMessage(type: String, message: [String : Any]) {
        print("Type: \(type), message: \(message)")
    }
    
    func onError(type: String, rawMessage: String) {
        print("Type: \(type), message: \(rawMessage)")
    }
    
    
}

