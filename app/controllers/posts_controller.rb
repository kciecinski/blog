class PostsController < ApplicationController
  before_action :authenticate_admin!, only: [:new,:create]
  #Get all posts
  def index
    @posts = Post.all
  end
  #Get new post form
  def new
    @post = Post.new
  end
#create new post if post is valid
  def create
    @post = Post.new(post_parms)
  if @post.save
      flash[:succes] = "Posted succesfully"
      redirect_to root_url
    else
      flash[:danger] = "Somthing went wrong"
      redirect_to root_url
    end
  end
  def edit
    find_post
  end
  def destroy
    find_post
    @post.destroy
    flash[:success] = "Post deleted succesfully"
    redirect_to root_url
  end
  def update
    find_post
    @post.update(post_parms)
    if @post.save
        flash[:succes] = "Edited succesfully"
        redirect_to root_url
      else
        flash[:danger] = "Somthing went wrong"
        redirect_to root_url
      end
  end
  def archived
    @posts = Post.where("strftime('%m', created_at) = ?","0#{created_params[:created_at].to_datetime.month.to_s}")
    puts "-----------------"
    puts "0#{created_params[:created_at].to_datetime.month.to_s}"
  end
private
#Strong parame
  def post_parms
     params.require(:post).permit(:title,:content,:tags)
  end
  def created_params
    params.permit(:created_at)
    end
  #FInd right post to edit/destroy
  def find_post
    @post = Post.find(params[:id])
  end
end
