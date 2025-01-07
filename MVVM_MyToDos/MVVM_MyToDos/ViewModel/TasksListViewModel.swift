//
//  TasksListViewModel.swift
//  MVVM_MyToDos
//
//  Created by Raúl Ferrer on 11/6/22.
//

import Foundation
import Combine

class TaskListViewModel {
    
    @Published private(set) var tasks: [TaskModel] = []
    private var cancellables = Set<AnyCancellable>()
    
    private(set) var tasksListModel: TasksListModel!
    private var taskService: TaskServiceProtocol!
    private var tasksListService: TasksListServiceProtocol!
    
    init(tasksListModel: TasksListModel,
         taskService: TaskServiceProtocol,
         tasksListService: TasksListServiceProtocol) {
        self.tasksListModel = tasksListModel
        self.taskService = taskService
        self.tasksListService = tasksListService
        fetchTasks()
        setupNotifications()
    }
    
    // MARK: Public Methods
    func deleteTask(at indexPath: IndexPath) {
        guard tasks.indices.contains(indexPath.row) else { return }
        taskService.deleteTask(tasks[indexPath.row])
    }
    
    func updateTask(at indexPath: IndexPath) {
        guard tasks.indices.contains(indexPath.row) else { return }
        var taskToUpdate = tasks[indexPath.row]
        taskToUpdate.done.toggle()
        taskService.updateTask(taskToUpdate)
    }
    
    private func setupNotifications() {
        NotificationCenter.default
            .publisher(for: NSNotification.Name.NSManagedObjectContextObjectsDidChange)
            .sink { [weak self] _ in
                self?.fetchTasks()
            }
            .store(in: &cancellables)
    }
    
    private func fetchTasks() {
        guard let list = tasksListService.fetchListWithId(tasksListModel.id) else { return }
        let orderedTasks = list.tasks.sorted {
            $0.createdAt.compare($1.createdAt) == .orderedDescending
        }
        tasks = orderedTasks
    }
}
