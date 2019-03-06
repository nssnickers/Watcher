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
    
    private var isLoadingProjects = false
    
    public var date: String?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        projectsTableView.register(
            UINib(nibName: projectCellNibName, bundle: nil),
            forCellReuseIdentifier: projectCellReuseIdentifier)
        
        view.addSubview(activityIndicator)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        isLoadingProjects = true
        
        projectService.obtainProjectsWithCompletion { (result) in
            self.isLoadingProjects = false
            if self.activityIndicator.isAnimating {
                self.activityIndicator.stopAnimating()
            }
            
            
            switch result {
            case .error:
                self.showAlertWithError(Alert.projectsUnavailable)
            case .success(let newProjects):
                self.projects = newProjects
                self.projectsTableView.reloadData()
            }
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isLoadingProjects {
            activityIndicator.startAnimating()
        }
    }
    
    
    override func viewWillLayoutSubviews() {
        activityIndicator.center = CGPoint(x: view.frame.size.width * 0.5, y: view.frame.size.height * 0.5)
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
        
        expense.date = date
        expense.project = project
        self.present(expense, animated: true, completion: nil)
    }
}
