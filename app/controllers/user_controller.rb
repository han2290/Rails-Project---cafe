class UserController < ApplicationController
    
    def index
        @users = User.all
        @current_user = User.find(session[:name]) if session[:name]
        
        
        
    end
    
    def show
        @user = User.find(params[:id])
    end
    
    def new
    end
    
    def create
        user = User.new
        user.name = params[:name]
        user.password = params[:password]
        user.ip_address = request.ip
        user.save
        
        redirect_to "/user/#{user.id}"
        
    end
    
    def edit
        @user = User.find(params[:id])
        
    end
    
    def update
        user = User.find(params[:id])
        user.name = params[:name]
        user.password = params[:password]
        user.ip_address = request.ip
        user.save
        
        redirect_to "/users"
    end    
    
    def sign_in
        #Login 여부 확인
        #만일, Login 되어있다면 다시 index로....
    end
    
    def login
        #유저가 입력한 ID, PW를 바탕으로
        #실제로 Login이 이루어 지는 곳
        id = params[:name]
        pw = params[:password]
        
        user = User.find_by_name(id) #만약 데이터를 찾지 못했다면, nil값이 된다.
        
        if !user.nil? and user.password.eql?(pw)
            #아이디가 존재하고 그 비밀번호가 일치할 때.
            session[:name] = user.id
            flash[:success] = "로그인 성공"
            redirect_to '/users'
        else
            flash[:error] = "가입된 유저가 아니거나, 비밀번호가 틀립니다."
            redirect_to "/sign_in"
        end
    end
    
    def logout
        session.delete(:name)
        flash[:success] = "성공적으로 로그아웃 하였습니다."
        redirect_to "/users"
    end
    
end
