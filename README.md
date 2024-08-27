![image](https://github.com/user-attachments/assets/52dedab9-9b56-4f78-bc99-598b62b8452f)
# iOS-Architecture-Pattern 뜯어 보기 
iOS-Architecture-Patterns를 읽고 각 아키텍쳐 구조를 알아보고 어떤 필요에 의해서 나왔는지 살펴봅니다. 

🐈‍⬛ [iOS Architecture Patterns Repository](https://github.com/Apress/iOS-Architecture-Patterns)

## 아키텍쳐에 앞서 각 컴포넌트 구현시 고려 사항 < SOLID 원칙 > [📚Wiki](https://github.com/OneMoreThink/iOS-Architecture-Patterns-Decomposition/wiki/%EC%95%84%ED%82%A4%ED%85%8D%EC%B3%90%EC%97%90-%EC%95%9E%EC%84%9C-%EA%B0%81-%EC%BB%B4%ED%8F%AC%EB%84%8C%ED%8A%B8-%EA%B5%AC%ED%98%84%EC%8B%9C-%EA%B3%A0%EB%A0%A4-%EC%82%AC%ED%95%AD-%E2%80%90-SOLID-%EC%9B%90%EC%B9%99)
- Single-Responsibility Principle (SRP)
- Open–Closed Principle (OCP)
- Liskov Substitution Principle (LSP)
- Interface Segregation Principle (ISP)
- Dependency Inversion Principle (DIP)

---

## MVC 패턴
![image](https://github.com/user-attachments/assets/3b65cb33-c7c0-4014-b293-1148d0258032)

### MVC 기본 Flow
MVC는 Model-View-Controller로 있고 전반적인 흐름은 다음과 같이 진행됩니다. 
1. **UserAction**: View는 사용자에게 입력을 받아 Controller에게 알려줍니다. 
   - View가 Controller에게 
   - 사용자가 화면 아래쪽에 ‘Task Add’ 버튼을 눌렀어요.
2. **Notify:** Controller는 해당 입력에 대한 동작을 Model에게 알려줍니다. 
   - Controller가 Model에게 
   - 버튼이 눌렀으니까 새로운 Task를 만들어서 CoreData에 저장해야해요. 
3. Model에서는 요청받은 동작을 실행한다. 
   - 새로운 Task를 만들고 CoreData저장을 실행해본다.

4. **Update:** Model은 동작의 결과를 Controller에게 알려줍니다. 
   - Model이 Controller에게
   - 정상적으로 저장까지 완료 했어요. 
5. **Render:** Controller는 받은 결과를 바탕으로 화면을 구성합니다. 
   - Controllere가 View에게 
   - 실행결과에 따르면 화면이 이렇게 구성되야해요. 
6. View는 구성된 화면을 렌더링해서 사용자에게 보여줍니다. 
   - ’Task Add’ 요청에 대한 결과는 이렇게 되었어요
  
### MVC를 구성하는 3가지 디자인 패턴 [📚Wiki](https://github.com/OneMoreThink/iOS-Architecture-Patterns-Decomposition/wiki/MVC-%ED%8C%A8%ED%84%B4%EC%9D%84-%EA%B5%AC%EC%84%B1%ED%95%98%EB%8A%94-3%EA%B0%80%EC%A7%80-%EB%94%94%EC%9E%90%EC%9D%B8-%ED%8C%A8%ED%84%B4)
- Composite Pattern
- Strategy Pattern
- Observer Pattern

### MVC 구성 요소 

#### Model 
모델은 비즈니스 로직을 가지고 있으며 어플리케이션의 데이터를 관리한다. 
- data persistence와 관련한 클래스(Core Data, SQLite, Realam, UserDefault 등)
- 네트워킹을 통한 데이터 통신에 관련한 클래스
- 외부로부터 받은 데이터를 어플리케이션에 맞게 파싱하는 클래스
- extensions, constants, helper classes 
- 모델들간의 상호작용
- 모델은 반드시 컨트롤러를 거쳐야한다. 모델과 뷰간의 연관관계가 잡히면 안된다. 

#### View
뷰는 유저에게 보여지는 부분을 나타낸다.
- UIKit, AppKit, Core Animation, Core Graphics 라이브러리와 같이 UI와 관련된
- 컨트롤러를 통해 모델에로부터의 데이터를 받아 화면에 표시한다. 
- 각 컴포넌트들은 유저로부터 입력을 받을 수 잇다. 

#### Controller
모델과 뷰 사이에서의 중간층 역할을 한다. 
- MVC 에서 메인이 되는 컴포넌트로 뷰와 모델 사이에서 상호작용을 돕는다. 
- 컨트롤러는 뷰가 유저로부터 받은 입력을 넘겨 받아 어떤 행동을 해야할지 결정하고 모델에게 이를 알린다. 
- 모델이 관리하고 있는 데이터의 변경이 있을 경우 이를 감지하고 새로운 화면을 구성해서 뷰에게 준다.
- 어플리케이션의 생명주기를 관리한다. 

### MVC 장단점
#### 장점 
- 아키텍쳐 디자인이 간단하다.
- 다른 아키텍쳐 패턴에 비해 코드를 덜 쓴다.
- Model, View, Controller의 책임이 명확하다. 
- 간단한 어플리케이션의 경우 빠르게 만들 수 있다. 

#### 단점
- 컨트롤러가 뷰, 모델에 모두 연관관계가 맺어져 있어 재사용이 불가능하다. 
- UIViewController를 받아 만든 컨트롤러는 뷰와 매우 밀접하게 연관되어 책임의  중복이 생긴다. 
- 컨트롤러에 비즈니스 로직 일부, 테이블 및 컬렉션의 delegate, DataSource, Navigation 등이 포함되어 뚱뚱한 컨트롤러가 될 수 있다. 

![image 5](https://github.com/user-attachments/assets/470a252e-f13a-4162-8761-9ebab1df10ef)
> View 와 Controller의 연관관계는 View로부터 독립적인 Controller의 테스트를 어렵게 한다. 


### MVC 구현

#### Model
- business logic
- data access and manipulation
- extensions, constants, etc. 
- Core Data, Extensions, Services, etc.

  - Observer design pattern을 통해 Model(발행자)과 Controller(구독자)로 만들어 Model의 변경사항을 Controller가 알 수 있도록 한다. 
- Model의 변경은 주로 Database 상에 CRUD를 통해 이루어진다. 
- CoreData는 내부적으로 notification을 발행하여 Model의 변경사항을 Controller에게 전달 할 수 있다. 
- CoreData
	- CoreDataManager : PersistentContainer와 Context를 관리하는 Manager으로서 어플리케이션과 영구 저장소 사이에서 엔티티를 관리하는 역할을 한다. 
	- EntityModelMapProtocol : Entity와 Model을 매핑해주는 프로토콜(Protocol]이다. 어플리케이션에서 사용하는 모델중에 영구저장소에 저장이 필요한 모델의 경우에는 해당 프로토콜을 채택하게 함으로써 엔티티와 연결을 해준다. 
	- TaskModel
	 - TaskListModel
- Services (Service 계층) : CoreDataManager 기능을 사용해 Task와 TaskList를 관리하는 기능을 제공 
- Extensions + Helpers (Architecture)

#### View 
- View는 사용자와의 상호작용을 담당하는 레이어다. 
- 버튼이나 라벨과 같이 간단한 컴포넌트
- 이러한 컴포넌트들이 합쳐진 하나의 간단한 뷰 
- 이러한 간단한 뷰들이 합쳐진 하나의 복잡한 뷰

- Buttons, Labels의 경우에는 `UILabel`과 `UIButton` 같은 `UIView`의 서브 클래스를 채택해서 기본적인 모양만 정의 해놓고 `translatesAutoresizingMaskIntoConstraints = false`를 내부적으로 호출함으로써 해당 컴포넌트를 사용하는 곳에서 레이아웃을 설정할 수 있도록한다. 
- Cell의 경우에는 표기할 속성 프로퍼티 및 해당 프로퍼티의 값들이 어떻게 배치될지에 대해 내부적으로 정의를 해놓고 Cell 안에 들어갈 내용의 경우에는 `setParameter`와 같은 메서드를 public으로 노출하여 해당 Cell을 사용하는 `UITableView`나 `UICollectionView`에서 Cell을 구성할 때 값을 넣어주도록 하였다. 
- View의 경우에는 앞서 정의한 컴포넌트들을 조합하여 사용하는 곳으로 컴포넌트들을 프로퍼티로 가지고 레이아웃을 배치하며 `UITableView`나 `UICollectionView`의 `dataSource` 및 `delegate`를 구현하여 각 컴포넌트들에 동작을 부여하고 있다. 

- View 레이어를 구성함에 있어 전체적으로 기본 구성은 미리 정해 놓되 안에 들어가는 내용이나 동작을 해당 컴포넌트를 사용하는 곳에서 결정할 수 있게 함으로써 재사용성을 높였다.
- 이를 위해서 delegate 패턴을 이용하여 **동작을 부여하는 곳**에서 해당 delegate 프로토콜 타입의 프로퍼티를 가지게 하고 **실제 동작을 구현하는 곳**에서 delegate를 채택하도록 한다. 

#### Controller
- View에서는 사용자 입력에 대한 동작을 Delegate 패턴을 활용해서 Controller에 위임하고 있다. 
- ~ViewProtocol을 통해 View 내부에서 필요한 동작을 정의하고 `delegate: ~ViewProtocol` 프로퍼티를 통해 View 내부에서 각 컴포넌트에 대해 동작을 부여해주고 있다. 
- Controller는 자신의 `view`가 가지고 있는 Protocol을 채택하여 해당 View의 사용자 상호작용과 c관련된 동작을 구현해준다. 
- Service를 Protocol을 이용해 추상화한뒤, Controller를 정의할 때는 앞서 정의한 ServiceProtocol 프로퍼티를 가지고 있게 한다. 그리고 이후에 Controller를 실제로 생성하는 시점에서 ServiceProtocol에 알맞는 구현체를 주입하는 의존성 주입의 방식을 이용한다. 
- Controller는 Model의 Service를 이용하여 View에서 필요한 동작을 직접 구현한다. 


### 컴포넌트별 Test시 고려사항 

1. Manager (예: CoreDataManager)
   - 초기화 및 설정: 데이터베이스나 저장소가 올바르게 설정되는지
   - CRUD 작업: 데이터 생성, 읽기, 업데이트, 삭제가 정상적으로 작동하는지
   - 트랜잭션 처리: 복잡한 작업이 원자적으로 수행되는지
   - 에러 처리: 예외 상황에서 적절히 대응하는지
   - 동시성 처리: 멀티스레드 환경에서 안전하게 작동하는지
   - 마이그레이션: 데이터 모델 변경 시 마이그레이션이 올바르게 수행되는지

2. Service
   - 비즈니스 로직: 핵심 비즈니스 규칙이 올바르게 구현되었는지
   - 데이터 변환: DTO와 도메인 모델 간 변환이 정확한지
   - 외부 의존성 처리: API 호출, 데이터베이스 접근 등이 올바르게 수행되는지
   - 에러 처리 및 예외 상황: 다양한 시나리오에서 적절히 대응하는지
   - 비동기 작업: 콜백이나 비동기 작업이 예상대로 동작하는지
   - 캐싱 및 성능: 데이터 캐싱이 효과적으로 이루어지는지

3. View
   - UI 요소 존재 여부: 필요한 모든 UI 컴포넌트가 올바르게 생성되었는지
   - 레이아웃: 다양한 디바이스 크기에서 레이아웃이 올바른지
   - 사용자 상호작용: 탭, 스와이프 등의 제스처가 올바르게 처리되는지
   - 데이터 바인딩: 모델 데이터가 UI에 정확히 반영되는지
   - 상태 변화: 다양한 상태(로딩, 에러, 빈 상태 등)가 올바르게 표시되는지
   - 접근성: VoiceOver 등 접근성 기능이 올바르게 작동하는지
   - 애니메이션: UI 애니메이션이 부드럽고 정확한지

4. Controller
   - 생명주기 메서드: viewDidLoad, viewWillAppear 등이 올바르게 호출되는지
   - 데이터 흐름: 모델에서 뷰로, 뷰에서 모델로의 데이터 흐름이 올바른지
   - 사용자 입력 처리: 버튼 탭, 텍스트 입력 등이 올바르게 처리되는지
   - 네비게이션: 화면 전환이 올바르게 이루어지는지
   - 의존성 주입: 필요한 모든 의존성이 올바르게 주입되는지
   - 상태 관리: 뷰 컨트롤러의 상태 변화가 올바르게 관리되는지
   - 메모리 관리: 메모리 누수가 없는지, 순환 참조가 발생하지 않는지


## MVP 패턴 

