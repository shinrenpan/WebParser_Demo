//
//  Copyright (c) 2023 shinren.pan@gmail.com All rights reserved.
//

import UIKit

extension ComicList {
    final class VO {
        lazy var mainView = makeMainView()
        lazy var list = makeList()
        var loadingView: UIView { makeLoadingView() }
        
        init() {
            addList()
        }
    }
}

// MARK: - Reload Somethig

extension ComicList.VO {}

// MARK: - Add Something

private extension ComicList.VO {
    func addList() {
        mainView.addSubview(list)
        
        NSLayoutConstraint.activate([
            list.topAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.topAnchor),
            list.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            list.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            list.bottomAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

// MARK: - Make Something

private extension ComicList.VO {
    func makeMainView() -> UIView {
        let result = UIView(frame: .zero)
        result.backgroundColor = .white
        return result
    }
    
    func makeList() -> UITableView {
        let result = UITableView(frame: .zero, style: .plain)
        result.translatesAutoresizingMaskIntoConstraints = false
        result.rowHeight = 60
        result.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        return result
    }
    
    func makeLoadingView() -> UIView {
        let result = UIView(frame: .zero)
        let loading = UIActivityIndicatorView(style: .large)
        loading.translatesAutoresizingMaskIntoConstraints = false
        result.addSubview(loading)
        
        NSLayoutConstraint.activate([
            loading.centerXAnchor.constraint(equalTo: result.centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: result.centerYAnchor),
        ])
        
        loading.startAnimating()
        
        return result
    }
}
