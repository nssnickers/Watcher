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
    
    // MARK: - IBOutlet
    @IBOutlet private weak var scrollView: UIScrollView!
    
    @IBOutlet private weak var descriptionTextView: UITextView!
    
    @IBOutlet private weak var hourDatePicker: UIDatePicker!
    
    @IBOutlet private weak var hourDatePickerHightConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var spentTimeLabel: UILabel!
    
    @IBOutlet private weak var logTimeButton: UIButton!
    
    // MARK: - Public Properties
    
    public var project: Project?
    
    // MARK: - Private Properties
    
    private var activityIndicator = UIActivityIndicatorView(style: .gray)
    
    private var keyboardHandler: KeyboardHandler?
    
    private var activeField: UIView?
    
    private var timeLogService = TimeLogService()
    
    private var spentTime = 0
    
    private var logDescription = ""
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextView?.contentInset = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        keyboardHandler = KeyboardHandler(withDelegate: self)
        keyboardHandler?.startKeyboardHandling()
        descriptionTextView.delegate = self
        logTimeButton?.isUserInteractionEnabled = false
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    // MARK: - IBAction
    
    @IBAction func hourButtonDidTap(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.hourDatePickerHightConstraint.constant = self.hourDatePickerHightConstraint.constant == 0 ? 208 : 0
            self.view.layoutIfNeeded()
        }
    }
    
    
    @IBAction func hourDatePickerChanged(_ sender: UIDatePicker) {
        let date = sender.date
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        spentTime = hour * 60 + minute
        spentTimeLabel?.text = "\(hour)ч \(minute)м" //TODO: локализация
        validateButton()
    }
    
    
    @IBAction func logTimeDuttonDidTapped(_ sender: Any) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        
        let timeLog = TimeLog(
            projectId: project?.id ?? 0,
            minutesSpent: spentTime,
            date: result,
            description: logDescription)
        
        activityIndicator.startAnimating()
        timeLogService.sendTimeLog(timeLog) { (result) in
            self.activityIndicator.stopAnimating()
            
            switch result {
            case .error(let error):
                self.showAlertWithError(error)
            case .success:
                self.logTimeButton.isUserInteractionEnabled = false
            }
        }
    }
    
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Private Methods
    
    private func showAlertWithError(_ error: String) {
        let alert = UIAlertController(
            title: NSLocalizedString("Внимание", comment: ""),
            message: error,
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("ОК", comment: ""), style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    private func validateButton() {
        if spentTime > 0,
            logDescription.count > 0,
            logDescription.contains("Добавить описание") == false {
            logTimeButton.isUserInteractionEnabled = true
            logTimeButton.backgroundColor = UIColor(named: "orangeyRed")
        } else {
            logTimeButton.isUserInteractionEnabled = false
            logTimeButton.backgroundColor = UIColor(named: "pastelOrangeyRed")
        }
    }
    
}


extension TimeLogViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        // TODO: переделать анимацию
        UIView.animate(withDuration: 0.5) {
            self.hourDatePickerHightConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        logDescription = textView.text
        validateButton()
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
