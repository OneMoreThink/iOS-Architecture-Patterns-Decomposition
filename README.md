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
  
### MVC를 구성하는 3가지 디자인 패턴 [📚Wiki]
- Composite Pattern
- Strategy Pattern
- Observer Pattern
