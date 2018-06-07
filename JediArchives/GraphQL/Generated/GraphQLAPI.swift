//  This file was automatically generated and should not be edited.

import Apollo

public final class AllFilmsQuery: GraphQLQuery {
  public static let operationString =
    "query AllFilms {\n  allFilms {\n    __typename\n    films {\n      __typename\n      ...ListFilmFragment\n    }\n  }\n}"

  public static var requestString: String { return operationString.appending(ListFilmFragment.fragmentString) }

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Root"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("allFilms", type: .object(AllFilm.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(allFilms: AllFilm? = nil) {
      self.init(snapshot: ["__typename": "Root", "allFilms": allFilms.flatMap { $0.snapshot }])
    }

    public var allFilms: AllFilm? {
      get {
        return (snapshot["allFilms"] as? Snapshot).flatMap { AllFilm(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "allFilms")
      }
    }

    public struct AllFilm: GraphQLSelectionSet {
      public static let possibleTypes = ["FilmsConnection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("films", type: .list(.object(Film.selections))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(films: [Film?]? = nil) {
        self.init(snapshot: ["__typename": "FilmsConnection", "films": films.flatMap { $0.map { $0.flatMap { $0.snapshot } } }])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of all of the objects returned in the connection. This is a convenience
      /// field provided for quickly exploring the API; rather than querying for
      /// "{ edges { node } }" when no edge data is needed, this field can be be used
      /// instead. Note that when clients like Relay need to fetch the "cursor" field on
      /// the edge to enable efficient pagination, this shortcut cannot be used, and the
      /// full "{ edges { node } }" version should be used instead.
      public var films: [Film?]? {
        get {
          return (snapshot["films"] as? [Snapshot?]).flatMap { $0.map { $0.flatMap { Film(snapshot: $0) } } }
        }
        set {
          snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "films")
        }
      }

      public struct Film: GraphQLSelectionSet {
        public static let possibleTypes = ["Film"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("title", type: .scalar(String.self)),
          GraphQLField("releaseDate", type: .scalar(String.self)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(id: GraphQLID, title: String? = nil, releaseDate: String? = nil) {
          self.init(snapshot: ["__typename": "Film", "id": id, "title": title, "releaseDate": releaseDate])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The ID of an object
        public var id: GraphQLID {
          get {
            return snapshot["id"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        /// The title of this film.
        public var title: String? {
          get {
            return snapshot["title"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "title")
          }
        }

        /// The ISO 8601 date format of film release at original creator country.
        public var releaseDate: String? {
          get {
            return snapshot["releaseDate"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "releaseDate")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        public struct Fragments {
          public var snapshot: Snapshot

          public var listFilmFragment: ListFilmFragment {
            get {
              return ListFilmFragment(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }
        }
      }
    }
  }
}

public final class FilmDetailQuery: GraphQLQuery {
  public static let operationString =
    "query FilmDetail($id: ID) {\n  film(id: $id) {\n    __typename\n    title\n    episodeID\n    releaseDate\n    director\n    characterConnection(first: 10) {\n      __typename\n      characters {\n        __typename\n        id\n        name\n      }\n    }\n  }\n}"

  public var id: GraphQLID?

  public init(id: GraphQLID? = nil) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Root"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("film", arguments: ["id": GraphQLVariable("id")], type: .object(Film.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(film: Film? = nil) {
      self.init(snapshot: ["__typename": "Root", "film": film.flatMap { $0.snapshot }])
    }

    public var film: Film? {
      get {
        return (snapshot["film"] as? Snapshot).flatMap { Film(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "film")
      }
    }

    public struct Film: GraphQLSelectionSet {
      public static let possibleTypes = ["Film"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("title", type: .scalar(String.self)),
        GraphQLField("episodeID", type: .scalar(Int.self)),
        GraphQLField("releaseDate", type: .scalar(String.self)),
        GraphQLField("director", type: .scalar(String.self)),
        GraphQLField("characterConnection", arguments: ["first": 10], type: .object(CharacterConnection.selections)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(title: String? = nil, episodeId: Int? = nil, releaseDate: String? = nil, director: String? = nil, characterConnection: CharacterConnection? = nil) {
        self.init(snapshot: ["__typename": "Film", "title": title, "episodeID": episodeId, "releaseDate": releaseDate, "director": director, "characterConnection": characterConnection.flatMap { $0.snapshot }])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The title of this film.
      public var title: String? {
        get {
          return snapshot["title"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "title")
        }
      }

      /// The episode number of this film.
      public var episodeId: Int? {
        get {
          return snapshot["episodeID"] as? Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "episodeID")
        }
      }

      /// The ISO 8601 date format of film release at original creator country.
      public var releaseDate: String? {
        get {
          return snapshot["releaseDate"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "releaseDate")
        }
      }

      /// The name of the director of this film.
      public var director: String? {
        get {
          return snapshot["director"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "director")
        }
      }

      public var characterConnection: CharacterConnection? {
        get {
          return (snapshot["characterConnection"] as? Snapshot).flatMap { CharacterConnection(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "characterConnection")
        }
      }

      public struct CharacterConnection: GraphQLSelectionSet {
        public static let possibleTypes = ["FilmCharactersConnection"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("characters", type: .list(.object(Character.selections))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(characters: [Character?]? = nil) {
          self.init(snapshot: ["__typename": "FilmCharactersConnection", "characters": characters.flatMap { $0.map { $0.flatMap { $0.snapshot } } }])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of all of the objects returned in the connection. This is a convenience
        /// field provided for quickly exploring the API; rather than querying for
        /// "{ edges { node } }" when no edge data is needed, this field can be be used
        /// instead. Note that when clients like Relay need to fetch the "cursor" field on
        /// the edge to enable efficient pagination, this shortcut cannot be used, and the
        /// full "{ edges { node } }" version should be used instead.
        public var characters: [Character?]? {
          get {
            return (snapshot["characters"] as? [Snapshot?]).flatMap { $0.map { $0.flatMap { Character(snapshot: $0) } } }
          }
          set {
            snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "characters")
          }
        }

        public struct Character: GraphQLSelectionSet {
          public static let possibleTypes = ["Person"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("name", type: .scalar(String.self)),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(id: GraphQLID, name: String? = nil) {
            self.init(snapshot: ["__typename": "Person", "id": id, "name": name])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The ID of an object
          public var id: GraphQLID {
            get {
              return snapshot["id"]! as! GraphQLID
            }
            set {
              snapshot.updateValue(newValue, forKey: "id")
            }
          }

          /// The name of this person.
          public var name: String? {
            get {
              return snapshot["name"] as? String
            }
            set {
              snapshot.updateValue(newValue, forKey: "name")
            }
          }
        }
      }
    }
  }
}

public final class CharacterDetailQuery: GraphQLQuery {
  public static let operationString =
    "query CharacterDetail($id: ID) {\n  person(id: $id) {\n    __typename\n    name\n    birthYear\n    eyeColor\n    gender\n    hairColor\n    skinColor\n    homeworld {\n      __typename\n      name\n    }\n    filmConnection(first: 10) {\n      __typename\n      films {\n        __typename\n        ...ListFilmFragment\n      }\n    }\n  }\n}"

  public static var requestString: String { return operationString.appending(ListFilmFragment.fragmentString) }

  public var id: GraphQLID?

  public init(id: GraphQLID? = nil) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Root"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("person", arguments: ["id": GraphQLVariable("id")], type: .object(Person.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(person: Person? = nil) {
      self.init(snapshot: ["__typename": "Root", "person": person.flatMap { $0.snapshot }])
    }

    public var person: Person? {
      get {
        return (snapshot["person"] as? Snapshot).flatMap { Person(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "person")
      }
    }

    public struct Person: GraphQLSelectionSet {
      public static let possibleTypes = ["Person"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .scalar(String.self)),
        GraphQLField("birthYear", type: .scalar(String.self)),
        GraphQLField("eyeColor", type: .scalar(String.self)),
        GraphQLField("gender", type: .scalar(String.self)),
        GraphQLField("hairColor", type: .scalar(String.self)),
        GraphQLField("skinColor", type: .scalar(String.self)),
        GraphQLField("homeworld", type: .object(Homeworld.selections)),
        GraphQLField("filmConnection", arguments: ["first": 10], type: .object(FilmConnection.selections)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(name: String? = nil, birthYear: String? = nil, eyeColor: String? = nil, gender: String? = nil, hairColor: String? = nil, skinColor: String? = nil, homeworld: Homeworld? = nil, filmConnection: FilmConnection? = nil) {
        self.init(snapshot: ["__typename": "Person", "name": name, "birthYear": birthYear, "eyeColor": eyeColor, "gender": gender, "hairColor": hairColor, "skinColor": skinColor, "homeworld": homeworld.flatMap { $0.snapshot }, "filmConnection": filmConnection.flatMap { $0.snapshot }])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The name of this person.
      public var name: String? {
        get {
          return snapshot["name"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      /// The birth year of the person, using the in-universe standard of BBY or ABY -
      /// Before the Battle of Yavin or After the Battle of Yavin. The Battle of Yavin is
      /// a battle that occurs at the end of Star Wars episode IV: A New Hope.
      public var birthYear: String? {
        get {
          return snapshot["birthYear"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "birthYear")
        }
      }

      /// The eye color of this person. Will be "unknown" if not known or "n/a" if the
      /// person does not have an eye.
      public var eyeColor: String? {
        get {
          return snapshot["eyeColor"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "eyeColor")
        }
      }

      /// The gender of this person. Either "Male", "Female" or "unknown",
      /// "n/a" if the person does not have a gender.
      public var gender: String? {
        get {
          return snapshot["gender"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "gender")
        }
      }

      /// The hair color of this person. Will be "unknown" if not known or "n/a" if the
      /// person does not have hair.
      public var hairColor: String? {
        get {
          return snapshot["hairColor"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "hairColor")
        }
      }

      /// The skin color of this person.
      public var skinColor: String? {
        get {
          return snapshot["skinColor"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "skinColor")
        }
      }

      /// A planet that this person was born on or inhabits.
      public var homeworld: Homeworld? {
        get {
          return (snapshot["homeworld"] as? Snapshot).flatMap { Homeworld(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "homeworld")
        }
      }

      public var filmConnection: FilmConnection? {
        get {
          return (snapshot["filmConnection"] as? Snapshot).flatMap { FilmConnection(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "filmConnection")
        }
      }

      public struct Homeworld: GraphQLSelectionSet {
        public static let possibleTypes = ["Planet"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .scalar(String.self)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(name: String? = nil) {
          self.init(snapshot: ["__typename": "Planet", "name": name])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The name of this planet.
        public var name: String? {
          get {
            return snapshot["name"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "name")
          }
        }
      }

      public struct FilmConnection: GraphQLSelectionSet {
        public static let possibleTypes = ["PersonFilmsConnection"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("films", type: .list(.object(Film.selections))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(films: [Film?]? = nil) {
          self.init(snapshot: ["__typename": "PersonFilmsConnection", "films": films.flatMap { $0.map { $0.flatMap { $0.snapshot } } }])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of all of the objects returned in the connection. This is a convenience
        /// field provided for quickly exploring the API; rather than querying for
        /// "{ edges { node } }" when no edge data is needed, this field can be be used
        /// instead. Note that when clients like Relay need to fetch the "cursor" field on
        /// the edge to enable efficient pagination, this shortcut cannot be used, and the
        /// full "{ edges { node } }" version should be used instead.
        public var films: [Film?]? {
          get {
            return (snapshot["films"] as? [Snapshot?]).flatMap { $0.map { $0.flatMap { Film(snapshot: $0) } } }
          }
          set {
            snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "films")
          }
        }

        public struct Film: GraphQLSelectionSet {
          public static let possibleTypes = ["Film"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("title", type: .scalar(String.self)),
            GraphQLField("releaseDate", type: .scalar(String.self)),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(id: GraphQLID, title: String? = nil, releaseDate: String? = nil) {
            self.init(snapshot: ["__typename": "Film", "id": id, "title": title, "releaseDate": releaseDate])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The ID of an object
          public var id: GraphQLID {
            get {
              return snapshot["id"]! as! GraphQLID
            }
            set {
              snapshot.updateValue(newValue, forKey: "id")
            }
          }

          /// The title of this film.
          public var title: String? {
            get {
              return snapshot["title"] as? String
            }
            set {
              snapshot.updateValue(newValue, forKey: "title")
            }
          }

          /// The ISO 8601 date format of film release at original creator country.
          public var releaseDate: String? {
            get {
              return snapshot["releaseDate"] as? String
            }
            set {
              snapshot.updateValue(newValue, forKey: "releaseDate")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }

          public struct Fragments {
            public var snapshot: Snapshot

            public var listFilmFragment: ListFilmFragment {
              get {
                return ListFilmFragment(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }
          }
        }
      }
    }
  }
}

public struct ListFilmFragment: GraphQLFragment {
  public static let fragmentString =
    "fragment ListFilmFragment on Film {\n  __typename\n  id\n  title\n  releaseDate\n}"

  public static let possibleTypes = ["Film"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("title", type: .scalar(String.self)),
    GraphQLField("releaseDate", type: .scalar(String.self)),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public init(id: GraphQLID, title: String? = nil, releaseDate: String? = nil) {
    self.init(snapshot: ["__typename": "Film", "id": id, "title": title, "releaseDate": releaseDate])
  }

  public var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  /// The ID of an object
  public var id: GraphQLID {
    get {
      return snapshot["id"]! as! GraphQLID
    }
    set {
      snapshot.updateValue(newValue, forKey: "id")
    }
  }

  /// The title of this film.
  public var title: String? {
    get {
      return snapshot["title"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "title")
    }
  }

  /// The ISO 8601 date format of film release at original creator country.
  public var releaseDate: String? {
    get {
      return snapshot["releaseDate"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "releaseDate")
    }
  }
}