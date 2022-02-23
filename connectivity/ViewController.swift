//
//  ViewController.swift
//  connectivity
//
//  Created by Ivan Stajcer on 22.02.2022..
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController {
    private let wcSession = WCSession.default
    @IBOutlet weak var fieldd: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let wcSession = WCSession.default
        print("Activated state...")
        print("Is paired: ", wcSession.isPaired)
        print("Is reachable: ", wcSession.isReachable)
    }

    @IBAction func onSendPressed(_ sender: Any) {
        print("Is paired: ", wcSession.isPaired)
        print("Is reachable: ", wcSession.isReachable)
        let text = fieldd.text ?? "empty"
        let data = text.split(separator: " ")
        let message = ["tableData": data]
        do {
            try wcSession.updateApplicationContext(message)
            wcSession.sendMessage(message) { reply in
                print("Reply received: ", reply)
            } errorHandler: { error in
                print("Error in immidiate messaging: ", error)
            }

            print("Updated application context :D ")
        } catch {
            print("Error while updating application context :(")
        }
    }
    
}

