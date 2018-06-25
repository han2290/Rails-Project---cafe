# Day 12

언제나 DB 모델링부터 확실하게 집고 넘어가야 한다.

메서드 체이닝



* 기존에는 `Post.new` 와 `Post.save` 같은 명령어를 사용하요 트랜젝션을 진행하였다. 하지만 이런 방식을 사용하게 되면 후에 컬럼의 수가 많아질때 코드가 길어질 수 있다. 이런 문제를 해결하기 위해 다른 방법을 사용할 수 있다.

* `Post.create`와 `Post.update`가 있다. 파라메터로 인자의 값을 직접 줄 수 있다.

  ```ruby
  Post.create(title: params[:title], contents: params[:contents], user_id: current_user.id)
  ```

  이 경우에, 굳이 save를 명시하지 않아도 `create`나 `update`가 자동으로 저장을 진행한다.

* 트랜젝션 결과에 따라 메서드는 `true`나 `false`를 반환한다. 이를 이용해서 결과를 보여줄 수 있다.



### 랜더링

 *뷰 파일을 파편화해서 조립하여 사용하기*

* 내가 원하는 변수를 원하는 부분에 놓는다. 조립해서 사용한다.

* 렌더링을 위한 부품들에게는 `_name.html.erb`와 같이 파일 이름을 준다.

* `<%= render 'name'%>`와 같은 명령어로 부품들을 불러와 사용할 수 있다. 
* 이런 것을 사용하는 이유는 코드의 중복성을 줄이기 위함도 있지만 유지보수를 할 때, 편하게 하기 위함이다.
* 파라메터를 넘기는 방법은 다음과 같다.
  `<%= render "ranking", 분해된 파일에서 사용하고자 하는 변수명: 실제 변수명 %>`

> board_controller

```ruby
  def index
    @posts = Post.all
    current_user
    @title = "indexxx"
  end
```



> _ranking.html.erb

```html
<p> <%= title %></p>
<p>1. 황교익</p>
<p>2. 황교익</p>
```





> board/index.html.erb

```html
<div>
    <ul class="list-group">
        <% @posts.each do |post| %>
            <a class = "list-group-item" href="/board/<%=post.id%>"><%=post.title%> </a>
        <%end%>
    </ul>
    
</div>
<hr>
<%= link_to "새글쓰기", "/board/new"%>

<%= render "ranking" ,title: @title%>
<%= render "article" %>
```

 컨트롤러에서 생긴 `@title`이라는 변수는 key값인 `:title`에 매칭되어 `_ranking` 파편을 가져올때 값을  title이라는 변수에 대입시켜준다.

 즉 `_ranking.html.erb`에 `title`이라는 변수를 선언해두면 어떤 페이지에서든지 렌더를 위해  파편화된 `ranking`파일을 가져올 때, 페이지의 변수를 렌더 파편의 변수 이름에 매칭시켜서 보내면 코드를 편하게 작성할 수 있다.



### scaffold 생성

`$ rails g scaffold theme title:string contents: text` 

```sql
Running via Spring preloader in process 3290
      invoke  active_record
      create    db/migrate/20180625024015_create_themes.rb
      create    app/models/theme.rb
      invoke    test_unit
      create      test/models/theme_test.rb
      create      test/fixtures/themes.yml
      invoke  resource_route
       route    resources :themes
      invoke  scaffold_controller
      create    app/controllers/themes_controller.rb
      invoke    erb
      create      app/views/themes
      create      app/views/themes/index.html.erb
      create      app/views/themes/edit.html.erb
      create      app/views/themes/show.html.erb
      create      app/views/themes/new.html.erb
      create      app/views/themes/_form.html.erb
      invoke    test_unit
      create      test/controllers/themes_controller_test.rb
      invoke    helper
      create      app/helpers/themes_helper.rb
      invoke      test_unit
      invoke    jbuilder
      create      app/views/themes/index.json.jbuilder
      create      app/views/themes/show.json.jbuilder
      create      app/views/themes/_theme.json.jbuilder
      invoke  assets
      invoke    coffee
      create      app/assets/javascripts/themes.coffee
      invoke    scss
      create      app/assets/stylesheets/themes.scss
      invoke  scss
      create    app/assets/stylesheets/scaffolds.scss
```



`$ rake routes`

```sql
    Prefix Verb   URI Pattern                Controller#Action
    themes GET    /themes(.:format)          themes#index
           POST   /themes(.:format)          themes#create
 new_theme GET    /themes/new(.:format)      themes#new
edit_theme GET    /themes/:id/edit(.:format) themes#edit
     theme GET    /themes/:id(.:format)      themes#show
           PATCH  /themes/:id(.:format)      themes#update
           PUT    /themes/:id(.:format)      themes#update
           DELETE /themes/:id(.:format)      themes#destroy
```



`resources :themes ` route 파일 설명 추가