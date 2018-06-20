Rails.application.routes.draw do
    #board
    root 'board#index'
    get '/boards'           => 'board#index'    #전체목록
    get '/board/new'        => 'board#new'      #새로만들기     
    get '/board/:id/'       => 'board#show'     #자세히보기
    post '/boards'          => 'board#create'   
    get '/board/:id/edit'   => 'board#edit'     #수정하기
    
    put '/board/:id'        => 'board#update'   #전체 수정 -다 지우고 다시 수정
    patch '/board/:id'      => 'board#update'   #일부 수정 -일부만
    #둘 다 사용하는 이유는 가끔 patch를 지원하지 않는 브라우저가 있기 떄문이다.
    
    delete '/board/:id'     => 'board#destory'  #제거
    
    #user
    get '/users'            => 'user#index'     #Read
    get '/sign_up'          => 'user#new'       #Create
    get '/sign_in'          => 'user#sign_in'   #Login
    post '/sign_in'         => 'user#login'
    get '/logout'           => 'user#logout'    #logout
    
    post '/users'           => 'user#create'
    get '/user/:id'         => 'user#show'      #Read
    get '/user/:id/edit'    => 'user#edit'      #Update
    put '/user/:id'         => 'user#update'
    patch '/user/:id'       => 'user#update'
    
    #cafe
    get '/cafes'            =>'cafe#index'
    get '/cafe/new'         =>'cafe#new'
    post '/cafes'           =>'cafe#create'
    get '/cafe/:id'         =>'cafe#show'
    get '/cafe/:id/edit'    =>'cafe#edit'
    put '/cafe/:id'         =>'cafe#update'
    patch '/cafe/:id'       =>'cafe#update'
    
    delete '/cafe/:id'      =>'cafe#delete'
    
    
    
end
