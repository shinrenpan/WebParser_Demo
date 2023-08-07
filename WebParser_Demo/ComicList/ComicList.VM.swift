//
//  Copyright (c) 2023 shinren.pan@gmail.com All rights reserved.
//

import Combine
import UIKit
import WebParser

extension ComicList {
    final class VM {
        @Published var state = ComicList.Models.State.none
        lazy var parser = makeParser()
        var comics: [ComicList.Models.DisplayComic] = []
    }
}

// MARK: - Do Action

extension ComicList.VM {
    func doAction(_ action: ComicList.Models.Action) {
        switch action {
        case .loadData:
            actionLoadData()
        }
    }
}

// MARK: - Handle Action

private extension ComicList.VM {
    func actionLoadData() {
        state = .loadingData
        
        Task {
            do {
                comics = try await parser.parse([ComicList.Models.DisplayComic].self)
                state = .loadedData
            }
            catch {
                state = .loadDataFail
            }
        }
    }
}

// MARK: - Response Action

private extension ComicList.VM {}

// MARK: - Convert Something

private extension ComicList.VM {}

// MARK: - Make Something

private extension ComicList.VM {
    func makeParser() -> Parser {
        let configure = Configuration(
            uri: "https://www.manhuagui.com/update/",
            retryInterval: 1,
            retryCount: 15,
            userAgent: .safari,
            javascript: makeJavascript()
        )
        
        return .init(configuration: configure)
    }
    
    func makeJavascript() -> String {
        return """
        var results = [];
        var list = $('.latest-list > ul > li');
        list.each(function() {
        var comic = new Object();
        comic.title = $(this).find('a').eq(0).attr('title');
        comic.detailURI = $(this).find('a').eq(0).attr('href');
        results.push(comic);
        });
        results;
        """
    }
}
