//
//  AddTaskViewModel.swift
//  MVVM_MyToDos
//
//  Created by Raúl Ferrer on 11/6/22.
//

import Foundation
import Combine

class AddTaskViewModel {
    
    // MARK: - Properties
     @Published private(set) var task: TaskModel
     @Published private(set) var shouldDismiss = false
     @Published var title = ""
     @Published var icon = "checkmark.seal.fill"
     
     private let taskService: TaskServiceProtocol
     private let tasksListModel: TasksListModel
     private var cancellables = Set<AnyCancellable>()

    init(tasksListModel: TasksListModel,
         taskService: TaskServiceProtocol) {
        self.tasksListModel = tasksListModel
        self.taskService = taskService
        self.task = TaskModel(
            id: ProcessInfo().globallyUniqueString,
            icon: "checkmark.seal.fill",
            done: false,
            createdAt: Date()
        )
        setupBindings()
    }
    
    // MARK: - Public Methods
      func addTask() {
          taskService.saveTask(task, in: tasksListModel)
          shouldDismiss = true
      }
      
      private func setupBindings() {
          // Title 업데이트
          $title
              .sink { [weak self] newTitle in
                  self?.task.title = newTitle
              }
              .store(in: &cancellables)
          
          // Icon 업데이트
          $icon
              .sink { [weak self] newIcon in
                  self?.task.icon = newIcon
              }
              .store(in: &cancellables)
      }
}
