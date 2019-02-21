//
//  ProjectsViewController.swift
//  Watcher
//
//  Created by Маргарита on 14/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Transport
import UIKit

private let projectCellNibName = "ProjectTableViewCell"
private let projectCellReuseIdentifier = "ProjectTableViewCellReuseIdentifier"

/// Экран выбора прокета
final class ProjectsViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet private weak var projectsTableView: UITableView!
    
    // MARK: - Private Properties
    
    private var activityIndicator = UIActivityIndicatorView(style: .gray)
    private var projectService = ProjectService()
    private var projects: [Project] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(activityIndicator)
        activityIndicator.center = CGPoint(x: view.frame.size.width * 0.5, y: view.frame.size.height * 0.5)
        
        projectsTableView.register(
            UINib(nibName: projectCellNibName, bundle: nil),
            forCellReuseIdentifier: projectCellReuseIdentifier)

        activityIndicator.startAnimating()
        projectService.obtainProjectsWithCompletion { (result) in
            self.activityIndicator.stopAnimating()
            
            switch result {
            case .error(let error):
                self.showAlertWithError(error)
            case .success(let newProjects):
                self.projects = newProjects
                self.projectsTableView.reloadData()
            }
        }
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    // MARK: - IBAction
    
    @IBAction private func closeButtonDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Private Methods
    
    private func showAlertWithError(_ error: String) {
        let alert = UIAlertController(title: Alert.title, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Alert.actionTitle, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}


// MARK: - UITableViewDataSource

extension ProjectsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = projectsTableView.dequeueReusableCell(
            withIdentifier: projectCellReuseIdentifier,
            for: indexPath) as! ProjectTableViewCell
        // swiftlint:enable force_cast
        cell.setupWithProjectName(projects[indexPath.item].name)
        
        return cell
    }
}


// MARK: - UITableViewDelegate

extension ProjectsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let expense = TimeLogViewController(nibName: nil, bundle: nil)
        let project = projects[indexPath.item]
        
        expense.project = project
        self.present(expense, animated: true, completion: nil)
    }
}
