//
//  EventDetailViewController.swift
//  WeekThreeAssessment
//
//  Created by Tim Green on 7/30/21.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // MARK: - Properties
    var event: Event?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = eventNameTextField.text, !name.isEmpty else { return }
        if let event = event {
            EventController.sharedInstance.updateEventDetails(event, name: name, date: datePicker.date)
        } else {
            EventController.sharedInstance.createEvent(name: name, timeOfDay: datePicker.date)
        }
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Functions
    func updateViews() {
        guard let event = event else { return }
        eventNameTextField.text = event.name
        datePicker.date = event.timeOfDay ?? Date()
    }
} // End of class
