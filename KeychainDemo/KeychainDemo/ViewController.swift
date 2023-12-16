import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPassword()
    }
    
    func savePassword() {
        debugPrint("Saving")
        do {
            try KeychainManager.savePassword(service: "com.uisameer.com",
                                     account: "sameer", password:
                                        "securepass".data(using: .utf8)!)
        } catch  {
            print(error.localizedDescription)
        }
        debugPrint("Done Saving")
    }
    
    func getPassword() {
        guard let data = KeychainManager.get(service: "com.uisameer.com", account: "sameer") else {
            return
        }
        
        let password = String(decoding: data, as: UTF8.self)
        print(password)
    }
}

