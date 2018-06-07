/// Copyright (c) 2018 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class FilmDetailViewController: UITableViewController {

  let filmID: String
  let dataSource = ListDataSource()

  init(filmID: String) {
    self.filmID = filmID
    super.init(style: .grouped)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
    loadFilmDetail()
  }

  func configure() {
    applyDarkStyle()
    dataSource.configure(with: tableView)
  }
}

// MARK: Table View
extension FilmDetailViewController {

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch dataSource.sections[indexPath.section] {
    case .references(_, let models):
      let model = models[indexPath.row]
      let detailVC = CharacterDetailViewController(characterID: model.id)
      navigationController?.pushViewController(detailVC, animated: true)
    default:
      break
    }
  }
}

// MARK: Data
extension FilmDetailViewController {

  func loadFilmDetail() {
    func infoItem(from key: String, with value: String?) -> InfoItem {
      return InfoItem(label: NSLocalizedString(key, comment: ""), value: value ?? "NA")
    }
    let query = FilmDetailQuery(id: filmID)
    Apollo.shared.client.fetch(query: query) { [weak tableView, weak dataSource] (result, error) in
      guard let film = result?.data?.film else {
        print("Error loading characters \(String(describing: error))")
        return
      }
      
      let infoItems = [
        infoItem(from: "Title", with: film.title),
        infoItem(from: "Episode", with: "\(film.episodeId ?? 0)"),
        infoItem(from: "Released", with: film.releaseDate),
        infoItem(from: "Director", with: film.director)
      ]
      
      var sections: [Section] = [.info(title: NSLocalizedString("Info", comment: ""), models: infoItems)]
      
      let characterItems = film.characterConnection?.characters?.flatMap { $0 }.map { RefItem(character: $0) }
      if let characterItems = characterItems, !characterItems.isEmpty {
        sections.append(.references(title: NSLocalizedString("Character", comment: ""), models: characterItems))
      }
      
      dataSource?.sections = sections
      tableView?.reloadData()
    }
  }

}
