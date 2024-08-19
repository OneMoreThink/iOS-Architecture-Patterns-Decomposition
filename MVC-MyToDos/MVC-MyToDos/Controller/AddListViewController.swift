//
//  AddListViewController.swift
//  MVC-MyToDos
//
//  Created by 이종선 on 8/18/24.
//

import UIKit

class AddListViewController: UIViewController {

    private var addListView = AddListView()
    private var tasksListService: TasksListServiceProtocol!
    
    init(tasksListService: TasksListServiceProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.tasksListService = tasksListService
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func loadView() {
        super.loadView()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        setupAddListView()
    }
    
    private func setupAddListView() {
        addListView.delegate = self
        self.view = addListView
    }
    
    
    private func backToHome() {
        navigationController?.popViewController(animated: true)
    }
}


extension AddListViewController: AddListViewDelegate {
    
    func addList(_ list: TasksListModel) {
        tasksListService.saveTasksList(list)
        backToHome()
    }
}


extension AddListViewController: BackButtonDelegate {
    
    func navigateBack() {
        backToHome()
    }
}

