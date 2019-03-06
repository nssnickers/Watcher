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
    
    @IBOutlet private weak var projectNameLabel: UILabel!
    
    @IBOutlet private weak var scrollView: UIScrollView!
    
    @IBOutlet private weak var descriptionTextView: UITextView!
    
    @IBOutlet private weak var hourDatePicker: UIDatePicker!
    
    @IBOutlet private weak var hourDatePickerHightConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var spentTimeLabel: UILabel!
    
    @IBOutlet private weak var logTimeButton: UIButton!
    
    // MARK: - Public Properties
    
    public var date: String?
    
    public var project: Project?
    
    // MARK: - Private Properties
    
    private var activityIndicator = UIActivityIndicatorView(style: .gray)
    
    private var keyboardHandler: KeyboardHandler?
    
    private var activeField: UIView?
    
    private var timeLogService = TimeLogService()
    
    private var spentTime = 0
    
    private var logDescription = ""
    
    public var logModel: LogViewModel?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextView?.contentInset = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        keyboardHandler = KeyboardHandler(withDelegate: self)
        descriptionTextView?.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        keyboardHandler?.startKeyboardHandling()
        
        if let logModel = logModel {
            // TODO: сделать вью модель для этого экрана
            projectNameLabel?.text = logModel.projectNameLabel
            descriptionTextView?.text = logModel.descriptionLabel
            spentTimeLabel?.text = logModel.spentHourLabel
            hourDatePicker?.date = DateFormatterManager.hourMinutesDateFormatter.date(
                from: "\(logModel.spentMinutes / 60):\(logModel.spentMinutes % 60)")!
            logTimeButton?.setTitle("Изменить", for: .normal)
            logTimeButton?.isUserInteractionEnabled = true
            
            // TODO: все плохо
            spentTime = logModel.spentMinutes
            logDescription = logModel.descriptionLabel
            
        } else {
            projectNameLabel?.text = project?.name
            logTimeButton?.isUserInteractionEnabled = false
        }
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
    
    
    @IBAction func logTimeButtonDidTapped(_ sender: Any) {
        if logModel?.identifier != nil {
            updateLog()
        } else {
            putLog()
        }
    }
    
    
    // MARK: - Private Methods
    
    private func putLog() {
        let timeLog = TimeToLog(
            projectId: project?.id ?? 0,
            minutesSpent: spentTime,
            date: date ?? DateFormatterManager.baseDateFormatter.string(from: Date()),
            description: logDescription)
        
        activityIndicator.startAnimating()
        timeLogService.sendTimeLog(timeLog) { (result) in
            
            self.activityIndicator.stopAnimating()
            
            switch result {
            case .error:
                self.showAlertWithError(Alert.logTimeUnavailable)
            case .success:
                self.logTimeButton.isUserInteractionEnabled = false
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    private func updateLog() {
        guard let logModel = logModel else {
            return
        }
        
        activityIndicator.startAnimating()
        
        let timeLog = TimeToUpdate(minutesSpent: spentTime, description: logDescription)
        timeLogService.updateTimeLog(timeLog, timeIdentifier: logModel.identifier) { (result) in
            self.activityIndicator.stopAnimating()
            
            switch result {
            case .error:
                self.showAlertWithError(Alert.updateTimeUnavailable)
            case .success:
                self.logTimeButton.isUserInteractionEnabled = false
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Private Methods
    
    private func showAlertWithError(_ error: String) {
        let alert = UIAlertController(title: Alert.title, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Alert.actionTitle, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    private func validateButton() {
        if spentTime > 0,
            logDescription.count > 0,
            logDescription.contains("Добавить описание") == false {
            logTimeButton.isUserInteractionEnabled = true
            logTimeButton.backgroundColor = Colors.red
        } else {
            logTimeButton.isUserInteractionEnabled = false
            logTimeButton.backgroundColor = Colors.pastelRed
        }
    }
    
}


// MARK: - UITextViewDelegate

extension TimeLogViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        // TODO: переделать анимацию
        UIView.animate(withDuration: AnimationDuration.slow) {
            self.hourDatePickerHightConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        logDescription = textView.text
        validateButton()
    }
}


// MARK: - KeyboardHandlerDataSource

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
