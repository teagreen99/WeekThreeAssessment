//
//  EventTableViewCell.swift
//  WeekThreeAssessment
//
//  Created by Tim Green on 7/30/21.
//

import UIKit

protocol EventCellDelegate: AnyObject {
    func eventWasAttendedTapped(wasAttended: Bool, event: Event)
}

class EventTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventWasAttendedButton: UIButton!
    
    // MARK: - Properties
    weak var delegate: EventCellDelegate?
    var event: Event?
    private var wasAttendedToday: Bool = false
    
    // MARK: - IBActions
    @IBAction func eventWasAttendedButtonTapped(_ sender: Any) {
        guard let event = event else { return }
        wasAttendedToday.toggle()
        delegate?.eventWasAttendedTapped(wasAttended: wasAttendedToday, event: event)
    }
    
    // MARK: - Functions
    func configure(with event: Event) {
        self.event = event
        wasAttendedToday = event.wasAttendedToday()
        
        eventNameLabel.text = event.name
        
        let image = wasAttendedToday ? UIImage(systemName: "clock") : UIImage(systemName: "clock.fill")
        print(wasAttendedToday)
        eventWasAttendedButton.setImage(image, for: .normal)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        event = nil
        wasAttendedToday = false
    }
} // End of class
