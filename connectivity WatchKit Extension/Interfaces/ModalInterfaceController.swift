//
//  ModalInterfaceController.swift
//  connectivity WatchKit Extension
//
//  Created by Ivan Stajcer on 23.02.2022..
//

import Foundation
import WatchKit

final class ModalInterfaceController: WKInterfaceController {
    @IBOutlet weak var label: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        print("awaken modal interface controller.")
        if let context = context as? String {
            label.setText(context)
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        print("Will activate modal interface controller.")
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        print("Will DEactivate modal interface controller.")
    }
    @IBAction func onButtonPressed() {
        dismiss()
    }
}
