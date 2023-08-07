//
//  Copyright (c) 2023 shinren.pan@gmail.com All rights reserved.
//

import Combine
import UIKit

extension ComicList {
    final class VC: UIViewController {
        var vo = ComicList.VO()
        var vm = ComicList.VM()
        var router = ComicList.Router()
        var binding = Set<AnyCancellable>()
        
        override func loadView() {
            self.view = vo.mainView
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupSelf()
            setupBinding()
            setupVO()
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            if vm.comics.isEmpty {
                vm.doAction(.loadData)
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension ComicList.VC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.comics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let comic = vm.comics[indexPath.row]
        cell.textLabel?.text = comic.title
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ComicList.VC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let comic = vm.comics[indexPath.row]
        router.showComicDetail(comic: comic)
    }
}

// MARK: - Setup Something

private extension ComicList.VC {
    func setupSelf() {
        router.vc = self
    }
    
    func setupBinding() {
        vm.$state.receive(on: DispatchQueue.main).sink { [weak self] state in
            switch state {
            case .none:
                self?.stateNone()
            case .loadingData:
                self?.stateLoadingData()
            case .loadedData:
                self?.stateLoadedData()
            case .loadDataFail:
                self?.stateLoadDataFail()
            }
        }.store(in: &binding)
    }
    
    func setupVO() {
        vo.list.delegate = self
        vo.list.dataSource = self
    }
}

// MARK: - Handle State

private extension ComicList.VC {
    func stateNone() {}
    
    func stateLoadingData() {
        view = vo.loadingView
    }
    
    func stateLoadedData() {
        view = vo.mainView
        vo.list.reloadData()
    }
    
    func stateLoadDataFail() {}
}
