class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  def index
    @comments = Comment.all
    respond_with(@comments)
  end

  def show
    respond_with(@comment)
  end

  def new
    @comment = Comment.new
    respond_with(@document)
  end

  def edit

  end

  def create
    if(current_user.admin)
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end

    @comment = Comment.new(comment_params)
    @comment.image_id = params[:image_id]
    @comment.save

    @image = Image.find(params[:image_id])
    @document = Document.find(@image.document_id)
    @user = User.find(@document.user_id)
  end

  def update
    @comment.update(comment_params)
    respond_with(@comment)
  end

  def destroy
    if(current_user.admin)
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end

    @document = Document.find(params[:document_id])
    @comment = @document.comments.find(params[:id])
    @comment.destroy
    redirect_to user_document_path(@user, @document)
    # @comment.destroy
    # respond_with(@comment)
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:value, :reviewed)
    end
end
