# Day 10



#### 다음 카페 내부 만들기

* controller/model에서 method 사용하기 + 필터

* Session(Login)
* Relation(1:n)
* Relation(m:n)-가능하면 진행
* 



#### 추가 과제(CRUD 두 개 만들기)

* User 모델과 UserController CRUD
  * columns: id, password, ip_address
  * show에서는 id와 ip 주소만 보이게(pw 제외)
  * delete 없음
  * /user/new -> /sign_up
* Cafe 모델과 CafeController CRUD
  * columns: title, description



### Cookie

 서버와 클라이언트의 요청과 응답은 모두 독립적이다. 이런 요청과 응답 사이의 데이터는 유지되지 않는다. 따라서 항상 유지되는 데이터 Cookie 사용할 수 있는데, Cookie를 클라이언트의 브라우저에 저장한다. 이 Cookie는 서버에서 응답시 데이터를 조금씩 보낸다.  이것은 해킹당할 위험이 있다. 그래서 이 문제점을 해결하기 위해 Session을 사용할 수 있다.



### Session

 Cookie는 정보 자체가 클라이언트 쪽에 있었다. Session은 정보를 서버가 가지고 있게 된다. 다만 클라이언트는 정보에 대한 ID값(Session_ID)을 가지게 된다.



#### 로그인 기능 추가

* 로그인 기능과 로그아웃 기능을 추가한다.
* 로그인 상태를 출력한다.

> UserController의 index

```ruby
def index
        @users = User.all
        @login_user = User.find(session[:name])
end
```

 만약 로그인을 하지 않고 `get '/users' `를 요청(`user#index`에 매핑)하면 에러가 발생한다. 그 이유는 `session[:name]`은 우리가 로그인이 성공할 경우에 `session[:name]`이 생성되도록 코드를 작성해놓았기 때문이다. `session[:name]`이 없으므로 find는 비어있는 값으로 인스턴스를 찾게된다. 그래서 *RecordNotFound Error*가 발생하게 되는 것이다.

따라서 코드를 다음과 같이 수정해야 한다.

```ruby
def index
        @users = User.all
        @login_user = User.find(session[:name]) if session[:name]
end
```

 이렇게 수정한다면  `if session[:name]`에 의해 `session[:name]`이 존재할 경우에만 `User.find`를 실행하게 될 것이다. 따라서 *RecordNotFound Error*를 해결하게 된다.