# 35-APPJAM-iOS-BBANGZIP

이번 학기는 진짜 제대로 공부하려 했는데, 또 어김없이 미루기만 하고 있다면? </br>
미루기는 이제 그만! 🥐 제 과제 빵점 🥨 에서 미리미리 꾸준히 공부하는 습관을 형성해봐요 </br>
</br>

# 🧑‍🍳 iOS Developer
|🔖 송여경</br>[@0gonge](https://github.com/0gonge)|🔖 조성민</br>[@SungMinCho-Kor](https://github.com/SungMinCho-Kor)|🔖 최유빈</br>[@choiyoubin](https://github.com/choiyoubin)|🔖 김송희</br>[@hongseekim](https://github.com/hongseekim)|
|:---:|:---:|:---:|:---:|
|<img src = "https://github.com/0gonge.png" width ="250">|<img src = "https://github.com/SungMinCho-Kor.png" width ="250">|<img src = "https://github.com/choiyoubin.png" width ="250">|<img src = "https://github.com/hongseekim.png" width ="250">|
|`프로젝트 세팅` `로그인` `마이페이지`|`오늘의 할일` `친구 목록`|`과목 관리하기` `시험 관리하기`|`온보딩` `과목 페이지 나누기`|
</br>

# 🥖 Dependency
|Library|Description|Version|
|:---:|:---:|:---:|
|**Alamofire**|추상화된 네트워크 레이어 사용|```5.10.2```|
|**KakaoOpenSDK**|카카오톡 간편로그인 연동|```2.23.0```|
<div>
  <img src="https://img.shields.io/badge/Xcode-16.0-007ACC?style=for-the-badge&logo=Xcode&logoColor=white" style="display:inline-block;">
  <img src="https://img.shields.io/badge/swift-6.0-F54A2A?style=for-the-badge&logo=swift&logoColor=white" style="display:inline-block;">
  <img src="https://img.shields.io/badge/Tuist-4.38.2-E34F26?style=for-the-badge&logo=Tuist&logoColor=white" style="display:inline-block;">
</div>
</br>

# 🍞 Git Flow
[우아한형제들 Git-flow](https://techblog.woowahan.com/2553/)를 기반으로 합니다.</br>
이슈명은 [Unit] 작업 내용 형식으로 작성합니다. (예시: [Feature] 컴포넌트 제작)
1. Project board에서 issue를 생성합니다.
2. develop 브랜치에서 새로운 브랜치로 checkout 합니다.
3. 해당 브랜치에서 작업을 진행하고, 작업을 나누어 commit합니다.
4. 작업 완료 후 빌드가 되는지 확인 후 push합니다.
5. PR을 작성합니다.
6. 모든 팀원들의 approve를 받은 후 merge합니다.
</br>

# 🥯 Branch Strategy
브랜치명은 해당하는 브랜치에 이슈번호를 붙여서 작성합니다. (예시: feature/#1)
|branch|description|
|:---:|:---:|
|**main**|완성된 버전의 코드를 저장하는 브랜치|
|**develop**|개발이 진행되는 동안 완성된 코드를 저장하는 브랜치|
|**feature**|작은 단위의 작업이 진행되는 브랜치|
|**hotfix**|긴급한 오류를 해결하는 브랜치|
|**release**|QA, Test, 앱 심사를 진행하는 브랜치|
</br>

# 🍞 Coding Convention
[스타일쉐어 Swift 가이드](https://github.com/StyleShare/swift-style-guide)를 기반으로 합니다.</br>
</br>

# 🥪 Commit Message
아래의 예시와 같이 작성합니다.
```
feat: 기능 구현 (#이슈번호)
fix: 기능 수정 (#이슈번호)
refactor: 리팩토링 (#이슈번호)
docs: 문서 수정 (문서 추가, 수정, 삭제, README) (#이슈번호)
test: 테스트 (테스트 코드 추가, 수정, 삭제: 비즈니스 로직에 변경 없음) (#이슈번호)
chore: 기타 변경사항 (빌드 스크립트 수정, assets, 패키지 매니저 등) (#이슈번호)
remove: 파일을 삭제하는 작업만 수행한 경우, 키워드 삭제 등등! (#이슈번호)
init: 초기 생성 (#이슈번호)
```
</br>

# 🍞 Foldering Strategy
```
├── 🥐 Project
|   ├── 🥯 BBANGZIP
│   │   ├── 🥨 Resources
│   │   │   ├── 🥖 Config
│   │   │   ├── 🥖 Font
│   │   │   ├── 🥖 Preview Content
│   │   ├── 🥨 Sources
│   │   │   ├── 🥖 Application
│   │   │   ├── 🥖 Data
│   │   │   │   ├── 🍞 Network
│   │   │   │   │   ├── 🧁 DataMapping
│   │   │   │   ├── 🍞 Repositories
│   │   │   │   │   ├── 🧁 Error
│   │   │   ├── 🥖 Domain
│   │   │   │   ├── 🍞 Entities
│   │   │   │   ├── 🍞 Interfaces
│   │   │   │   │   ├── 🧁 Repositories
│   │   │   │   ├── 🍞 UseCases
│   │   │   ├── 🥖 Font
│   │   │   ├── 🥖 Presentation
│   │   │   │   └── 🍞 Main
│   │   │   │       ├── 🧁 View
│   │   │   │       └── 🧁 ViewModel
│   │   ├── 🥨 Tests
│   │       
└── 🥐 Derived
    ├── 🥯 InfoPlists
    └── 🥯 Sources
```
</br>

# 🧑‍🍳 BBANGZIP BOSS
<figure class="half">
<a href="link"><img src="https://github.com/user-attachments/assets/b68e30ed-d7ad-426e-8a0e-96186f10ecfb"width="60%"></a>
<figure class="half">
</br>

