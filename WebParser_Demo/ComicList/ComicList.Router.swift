//
//  Copyright (c) 2023 shinren.pan@gmail.com All rights reserved.
//

import UIKit
import SafariServices

extension ComicList {
    final class Router {
        weak var vc: ComicList.VC?
    }
}

// MARK: - Route to

extension ComicList.Router {
    func showComicDetail(comic: ComicList.Models.DisplayComic) {
        let uri = "https://www.manhuagui.com" + comic.detailURI
        
        if let url = URL(string: uri) {
            let to = SFSafariViewController(url: url)
            vc?.present(to, animated: true)
        }
    }
}
