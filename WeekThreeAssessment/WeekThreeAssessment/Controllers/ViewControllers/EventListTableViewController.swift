//
//  EventListTableViewController.swift
//  WeekThreeAssessment
//
//  Created by Tim Green on 7/30/21.
//

import UIKit

class EventListTableViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        EventController.sharedInstance.fetchEvents()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }

    
    // MARK: - Functions
    override func numberOfSections(in tableView: UITableView) -> Int {
        return EventController.sharedInstance.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventController.sharedInstance.sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventTableViewCell else { return UITableViewCell() }
        
        let event = EventController.sharedInstance.sections[indexPath.section][indexPath.row]
        
        cell.configure(with: event)
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let event = EventController.sharedInstance.sections[indexPath.section][indexPath.row]
            EventController.sharedInstance.deleteEvent(event)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Still Need to Complete"
        } else if section == 1 {
            return "Completed"
        }
        return nil
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEventDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? EventDetailViewController else { return }
            let event = EventController.sharedInstance.sections[indexPath.section][indexPath.row]
            destination.event = event
        }
    }
} // End of class

extension EventListTableViewController: EventCellDelegate {
    func eventWasAttendedTapped(wasAttended: Bool, event: Event) {
        EventController.sharedInstance.updateEventStatus(wasAttended, event: event)
        tableView.reloadData()
    }
} // End of extension

