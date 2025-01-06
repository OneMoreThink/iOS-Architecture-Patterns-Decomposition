//
//  AddListViewModel.swift
//  MVVM_MyToDos
//
//  Created by Raúl Ferrer on 11/6/22.
//

import Foundation
import Combine

class AddListViewModel {
    
    @Published private(set) var list: TasksListModel
    @Published private(set) var shouldDismiss = false
    @Published var title = ""
    @Published var icon = "checkmark.seal.fill"
    private var cancellables = Set<AnyCancellable>()
    
    private var tasksListService: TasksListServiceProtocol!
    
    init(tasksListService: TasksListServiceProtocol) {
        self.tasksListService = tasksListService
        self.list = TasksListModel(id: ProcessInfo().globallyUniqueString,
                                   icon: "checkmark.seal.fill",
                                   createdAt: Date())
        setupBindings()
    }
    // MARK: - Public Methods
        func addList() {
            tasksListService.saveTasksList(list)
            shouldDismiss = true
        }
        
        func dismiss() {
            shouldDismiss = true
        }
        
        private func setupBindings() {
            // Title 업데이트
            $title
                .sink { [weak self] newTitle in
                    self?.list.title = newTitle
                }
                .store(in: &cancellables)
            
            // Icon 업데이트
            $icon
                .sink { [weak self] newIcon in
                    self?.list.icon = newIcon
                }
                .store(in: &cancellables)
        }
}
