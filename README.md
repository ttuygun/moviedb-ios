# moviedb-ios project

### Installing dependencies

Make sure you installed [Carthage](https://github.com/Carthage/Carthage/) on your system and run this command to install all required packages.

```bash
make install
```

### Settings

You must get a **API Key (v3 Auth)** from https://developers.themoviedb.org/ and update the `INSERT_API_KEY_HERE` in the `NetworkPlatform/API/MDApi.swift` *(line 70)*

### Architecture

In this project, I implemented the software architecture **MVVM-C** (Model–view–viewmodel with **clean architecture**) with **RxSwift** proposed by sergdort. I also re-implemented the network abstraction layer (NetworkPlatform) with [Moya](https://github.com/Moya/Moya) from scratch.

### Libraries

1. RxSwift
2. Moya
3. Kingfisher

### To-dos

- [ ] Unit tests
- [ ] UI tests
- [ ] Documentation
