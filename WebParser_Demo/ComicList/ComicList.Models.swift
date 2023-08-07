//
//  Copyright (c) 2023 shinren.pan@gmail.com All rights reserved.
//

import UIKit

extension ComicList {
    enum Models {}
}

// MARK: - Action

extension ComicList.Models {
    enum Action {
        case loadData
    }
}

// MARK: - State

extension ComicList.Models {
    enum State {
        case none
        case loadingData
        case loadedData
        case loadDataFail
    }
}

// MARK: - Display Model

extension ComicList.Models {
    struct DisplayComic: Decodable {
        let title: String
        let detailURI: String
    }
}
