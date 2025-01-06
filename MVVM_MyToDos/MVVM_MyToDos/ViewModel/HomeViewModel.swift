//
//  HomeViewModel.swift
//  MVVM_MyToDos
//
//  Created by Raúl Ferrer on 11/6/22.
//

import Foundation
import Combine

class HomeViewModel {
    
    // MARK: Publishers
    @Published private(set) var lists: [TasksListModel] = []
    @Published private(set) var selectedList: TasksListModel?
    
    private var cancellables = Set<AnyCancellable>()
    private let tasksListService: TasksListServiceProtocol
    
    init(tasksListService: TasksListServiceProtocol) {
        self.tasksListService = tasksListService
        fetchLists()
        setupNotifications()
    }
    
    // MARK: Public Methods
    func deleteList(at indexPath: IndexPath) {
        guard lists.indices.contains(indexPath.row) else { return }
        tasksListService.deleteList(lists[indexPath.row])
    }
    
    func selectList(at indexPath: IndexPath) {
        guard lists.indices.contains(indexPath.row) else { return }
        selectedList = lists[indexPath.row]
    }
    
    private func setupNotifications() {
        NotificationCenter.default
            .publisher(for: NSNotification.Name.NSManagedObjectContextObjectsDidChange)
            .sink { [weak self] _ in
                self?.fetchLists()
            }
            .store(in: &cancellables)
    }
    
    private func fetchLists() {
        lists = tasksListService.fetchLists()
    }
}
