# moviedb-ios project

### Installing dependencies

Make sure you installed [Carthage](https://github.com/Carthage/Carthage/) on your system and run this command to install all required packages.

```bash
make install
```

### Settings

You must get a **API Key (v3 Auth)** from https://developers.themoviedb.org/ and update the `INSERT_API_KEY_HERE` in the `NetworkPlatform/API/MDApi.swift` *(line 70)*

### Architecture

In this project, I used **MVVM-C** (Model–view–viewmodel and **clean architecture**) with **RxSwift* proposed by sergdort. I implement NetworkPlatform with Moya (network abstraction layer)

### Libraries

1. RxSwift
2. Moya
3. Kingfisher
4. XCDYouTubeKit


### To-dos

- [ ] Unit tests
- [ ] UI tests
- [ ] Documentation
