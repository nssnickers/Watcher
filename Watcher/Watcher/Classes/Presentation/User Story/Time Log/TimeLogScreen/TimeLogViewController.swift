//
//  TimeLogViewController.swift
//  Watcher
//
//  Created by Маргарита on 17/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Transport
import UIKit

final class TimeLogViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var hourDatePicker: UIDatePicker!
    
    @IBOutlet weak var hourDatePickerHightConstraint: NSLayoutConstraint!
    
    private var keyboardHandler: KeyboardHandler?
    private var activeField: UIView?
    private var timeLogService = TimeLogService()
    public var project: Project?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextView?.contentInset = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        keyboardHandler = KeyboardHandler(withDelegate: self)
        keyboardHandler?.startKeyboardHandling()
        descriptionTextView.delegate = self
        
    }
    
    
    @IBAction func hourButtonDidTap(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.hourDatePickerHightConstraint.constant = self.hourDatePickerHightConstraint.constant == 0 ? 208 : 0
            self.view.layoutIfNeeded()
        }
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    @IBAction func logTimeDuttonDidTapped(_ sender: Any) {
        let timeLog = TimeLog(projectId: project?.id ?? 0, minutesSpent: 20, date: "2019-01-17", description: "test")
        timeLogService.sendTimeLog(timeLog, nil)
    }
    
}


extension TimeLogViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("text start editing")
        UIView.animate(withDuration: 0.5) {
            self.hourDatePickerHightConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
}


extension TimeLogViewController: KeyboardHandlerDataSource {
    func containerScrollView() -> UIScrollView? {
        return scrollView
    }
    
    func activeView() -> UIView? {
        return descriptionTextView.isFirstResponder ? descriptionTextView : nil
    }
    
    func superviewFrame() -> CGRect {
        return self.view.frame
    }
}
