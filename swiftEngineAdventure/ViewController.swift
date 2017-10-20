//
//  ViewController.swift
//  swiftEngineAdventure
//
//  Created by Marty Hernandez Avedon on 10/19/17.
//  Copyright © 2017 Marty's . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var userInput: UITextField!
    
    var manager: APIRequestManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.manager = APIRequestManager()
        
        
    }
    
    @IBAction func enterButtonWasTapped(_ sender: UIButton) {
 //       let randomUserID = arc4random_uniform(UInt32.max)
        
//        if let userText = userInput.text {
//            manager.storeData(endpoint: Enspoint.post, data: ["user\(randomUserID)": userText]) { (data: Data?) in
//                if let validData = data {
//                    do {
//                        let json = try JSONSerialization.jsonObject(with: validData, options: [])
//                        print(json)
//                    }
//                    catch {
//                        print("error making post request")
//                    }
//                }
//            }
//
//        }
        guard let requestNumber = userInput?.text else { return }
        
        let getRequest = "\(Endpoint.get)=\(String(describing: requestNumber))"
        
        manager.getData(endPoint: getRequest) { (data: Data?) in
            if let validData = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: validData, options: [])
                    
                    guard let results = json as? [String : Any],
                        let response = results["response"] else {
                        throw ParsedJSON.error
                    }
                    
                    self.display(response)
                }
                catch {
                    print("error making get request")
                }
            }
        }
    }
    
    
    func display(_ json: Any) {
        let text = String(describing: json)
        
        DispatchQueue.main.async {
            self.textView.text = text
        }
    }
}

