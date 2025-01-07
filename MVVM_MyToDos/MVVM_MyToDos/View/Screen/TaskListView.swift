//
//  TaskListView.swift
//  MVVM_MyToDos
//
//  Created by Raúl Ferrer on 11/6/22.
//

import UIKit
import Combine

protocol TaskListViewControllerDelegate: AnyObject {
    func addTask()
}

class TaskListView: UIView {
    
    private(set) var backButton = BackButton(frame: .zero)
    private(set) var pageTitle = PageLabel(frame: .zero)
    private(set) var tableView = UITableView(frame: .zero, style: .grouped)
    private(set) var addTaskButton = MainButton(title: "Add Task", color: .mainCoralColor)
    private(set) var emptyState = EmptyStateView(frame: .zero, title: "Press 'Add Task' to add your first task to the list")
    private var tasks = [TaskModel]()
    
    private let viewModel: TaskListViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    weak var delegate: (TaskListViewControllerDelegate & BackButtonDelegate)?

    init(frame: CGRect = .zero, viewModel: TaskListViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .white
        configureBackButton()
        configurePageTitleLabel()
        configureAddTaskButton()
        configureTableView()
        configureEmptyState()
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBindings() {
        // Tasks 바인딩
        viewModel.$tasks
            .receive(on: DispatchQueue.main)
            .sink { [weak self] tasks in
                self?.tableView.reloadData()
                self?.emptyState.isHidden = !tasks.isEmpty
            }
            .store(in: &cancellables)
        
        // Add Task 버튼 액션
        addTaskButton.addTarget(self, action: #selector(addTaskButtonTapped), for: .touchUpInside)
        
        // Back 버튼 액션
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc private func addTaskButtonTapped() {
        delegate?.addTask()
    }
    
    @objc private func backButtonTapped() {
        delegate?.navigateBack()
    }
}

private extension TaskListView {
    
    func configureBackButton() {
        addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            backButton.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func configurePageTitleLabel() {
        addSubview(pageTitle)
        
        NSLayoutConstraint.activate([
            pageTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            pageTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            pageTitle.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            pageTitle.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        pageTitle.text = viewModel.tasksListModel.title
    }
    
    func configureAddTaskButton() {
        addSubview(addTaskButton)
        
        NSLayoutConstraint.activate([
            addTaskButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addTaskButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            addTaskButton.widthAnchor.constraint(equalToConstant: 200),
            addTaskButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        tableView.bounces = false
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.reuseId)
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            tableView.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: addTaskButton.topAnchor, constant: -40)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configureEmptyState() {
        addSubview(emptyState)
        
        NSLayoutConstraint.activate([
            emptyState.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 20),
            emptyState.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: -20),
            emptyState.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 20),
            emptyState.bottomAnchor.constraint(equalTo: addTaskButton.topAnchor, constant: -40)
        ])
    }
    
}


extension TaskListView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.reuseId, for: indexPath) as! TaskCell
        cell.setParametersForTask(viewModel.tasks[indexPath.row], at: indexPath.row)
        cell.checkButton.addTarget(self, action: #selector(checkButtonTapped(_:)), for: .touchUpInside)
        cell.checkButton.tag = indexPath.row
        return cell
    }
    
    @objc private func checkButtonTapped(_ sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        viewModel.updateTask(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteTask(at: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
