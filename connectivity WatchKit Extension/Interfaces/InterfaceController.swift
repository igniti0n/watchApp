//
//  InterfaceController.swift
//  watch WatchKit Extension
//
//  Created by Ivan Stajcer on 17.02.2022..
//

import WatchKit
import Foundation
import WatchConnectivity


class HomeInterfaceController: WKInterfaceController, WCSessionDelegate {
    @IBOutlet weak var label: WKInterfaceLabel!
    let wcSession = WCSession.default
    var tableData = [String]()
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("@session did complete with: acctivation state: ", activationState.rawValue)
        print("Activated state...")
        print("Is reachable: ", wcSession.isReachable)
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("Received message: ", message)
        label.setText(message["data"] as? String ?? "n/a")
        print("Received context:", wcSession.receivedApplicationContext)
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        guard let tableData = message["data"] as? Array<String> else {
            print("Table data is not array, rather: ", message["data"])
            replyHandler(["reply": "I didnt get good data :("])
            return
        }
        print("Received data: ", tableData)
        self.tableData = tableData
        replyHandler(["reply": "All good!"])
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("Received application context: ", applicationContext)
        if let text = applicationContext["data"] as? String {
            label.setText(text)
        } else {
            print("Application context data key does not hold a string, rather: ", applicationContext["data"])
        }
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String) -> Any? {
        return tableData
    }

    override func awake(withContext context: Any?) {
        wcSession.delegate = self
        wcSession.activate()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

}
