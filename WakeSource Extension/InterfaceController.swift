//
//  InterfaceController.swift
//  WakeSource Extension
//
//  Created by Vladyslav Yemets on 12/12/18.
//  Copyright © 2018 Vladyslav Yemets. All rights reserved.
//

import WatchKit
import Foundation
//import WatchConnectivity


class InterfaceController: WKInterfaceController {

    @IBOutlet var table: WKInterfaceTable!
    @IBOutlet var buttonPing: WKInterfaceButton!
    @IBOutlet var buttonClear: WKInterfaceButton!
    
    private var events = [String]()
//    private var sessionDelegate: WatchSessionDelegate<String>?
    
    // MARK: - Overriden
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        let rowType = String(describing: EventTableRow.self)
        table.setRowTypes([rowType])
        
//        sessionDelegate = WCSession.default.delegate as? WatchSessionDelegate<String>
//        sessionDelegate?.messageReceived = { [weak self] message in
//            self?.addEvent(message)
//        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func didAppear() {
        
    }

    // MARK: - Table methods
    
    // MARK: - Private
    
    private func reloadTable() {
        let rowType = String(describing: EventTableRow.self)
        table.setNumberOfRows(events.count, withRowType: rowType)
        for index in 0..<table.numberOfRows {
            let row = table.rowController(at: index) as? EventTableRow
            let event = events[index]
            row?.labelEvent.setText(event)
        }
    }
    
    private func addEvent(_ event: String) {
        events.append(event)
        reloadTable()
    }
    
    private func clearTable() {
        events.removeAll()
        reloadTable()
    }
    
    // MARK: - Actions
    
    @IBAction func onPing() {
        addEvent("Button tapped")
    }
    
    @IBAction func onClear() {
        clearTable()
    }
    
}


final class EventTableRow: NSObject {
    @IBOutlet weak var labelEvent: WKInterfaceLabel!
}
