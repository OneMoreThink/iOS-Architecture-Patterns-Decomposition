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
   - 새로운 Task를 만들고 CoreData저장을 ~실행해본다.~ 

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

## MVC 구성 요소 

### Model 
모델은 비즈니스 로직을 가지고 있으며 어플리케이션의 데이터를 관리한다. 
- data persistence와 관련한 클래스(Core Data, SQLite, Realam, UserDefault 등)
- 네트워킹을 통한 데이터 통신에 관련한 클래스
- 외부로부터 받은 데이터를 어플리케이션에 맞게 파싱하는 클래스
- extensions, constants, helper classes 
- 모델들간의 상호작용
- 모델은 반드시 컨트롤러를 거쳐야한다. 모델과 뷰간의 연관관계가 잡히면 안된다. 

### View
뷰는 유저에게 보여지는 부분을 나타낸다.
- UIKit, AppKit, Core Animation, Core Graphics 라이브러리와 같이 UI와 관련된
- 컨트롤러를 통해 모델에로부터의 데이터를 받아 화면에 표시한다. 
- 각 컴포넌트들은 유저로부터 입력을 받을 수 잇다. 

### Controller
모델과 뷰 사이에서의 중간층 역할을 한다. 
- MVC 에서 메인이 되는 컴포넌트로 뷰와 모델 사이에서 상호작용을 돕는다. 
- 컨트롤러는 뷰가 유저로부터 받은 입력을 넘겨 받아 어떤 행동을 해야할지 결정하고 모델에게 이를 알린다. 
- 모델이 관리하고 있는 데이터의 변경이 있을 경우 이를 감지하고 새로운 화면을 구성해서 뷰에게 준다.
- 어플리케이션의 생명주기를 관리한다. 

## MVC 장단점
### 장점 
- 아키텍쳐 디자인이 간단하다.
- 다른 아키텍쳐 패턴에 비해 코드를 덜 쓴다.
- Model, View, Controller의 책임이 명확하다. 
- 간단한 어플리케이션의 경우 빠르게 만들 수 있다. 

### 단점
- 컨트롤러가 뷰, 모델에 모두 연관관계가 맺어져 있어 재사용이 불가능하다. 
- UIViewController를 받아 만든 컨트롤러는 뷰와 매우 밀접하게 연관되어 책임의  중복이 생긴다. 
- 컨트롤러에 비즈니스 로직 일부, 테이블 및 컬렉션의 delegate, DataSource, Navigation 등이 포함되어 뚱뚱한 컨트롤러가 될 수 있다. 

![image 5](https://github.com/user-attachments/assets/470a252e-f13a-4162-8761-9ebab1df10ef)
> View 와 Controller의 연관관계는 View로부터 독립적인 Controller의 테스트를 어렵게 한다. 




