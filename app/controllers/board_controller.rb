class BoardController < ApplicationController
  #before_action(:set_post, :only => [:show, :edit, :update, :destory])
  before_action(:set_post, only: [:show, :edit, :update, :destory])
  before_action(:authenticate_user!, except: [:index, :show])
  #before_action(:set_post, except: [:index, :new, :create])
  
  # 로그인 된 상태에서만 점속할 수 있는 페이지는? - 개발자 마음대로..
  # index, show만 로그인 하지 않은 상태에서 볼 수 있게
  # 나머지는 반드시 로그인이 필수
  
  # Read
  def index
    @posts = Post.all
    current_user
    @title = "indexxx"
  end

  def show
  end

  def new
    
  end
  
  def create
    post = #new와 save를 한꺼번에 진행하는 create 메서드 이다.
      Post.create(post_params)
    # post.title=params[:title]
    # post.contents=params[:contents]
    # post.user_id = current_user.id
    # post.save
    #post를 등록할 때 이 글을 작성한 사람은 현재 로그인한 유저
    puts "result"
    p post_params
    puts "end--------"
    redirect_to "/board/#{post.id}"
  end
  

  def edit
  end
  
  def update
    @post.update(post_params)
    #원래 있던 내용물을 바로 update 시키므로 save가 불필요하다.
    redirect_to "/board/#{post.id}"
  end
  
  def destory
    @post.destroy
    
    redirect_to "/boards"
  end
  
  
  
  private #이 밑으로는 외부에서 접근 불가
  
  def set_post
    @post = Post.find(params[:id])
  end
  
  def post_params #parameter
    {title: params[:title], contents: params[:contents], user_id: current_user.id}
  end
  
  
end
