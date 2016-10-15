class PostController < Controller
  def index
    @posts = Post.all
  end    
end