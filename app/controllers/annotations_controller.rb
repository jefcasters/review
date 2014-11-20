require 'json'
class AnnotationsController < ApplicationController

  before_action :authenticate_user!
  def index
    @image = Image.find(params[:image_id])
    @annotations = @image.comments
    # render :json=> @annotations.to_json
  end

  def show
    @annotation = Comment.find(params[:id])
    #render json: @annotation.as_json(only: [:json])
  end

  def new

  end

  def edit
  end

  def create
    if(current_user.admin)
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end
    annotation_json=params[:annotation]
    annotation_hash=JSON.parse(annotation_json)
    @image = Image.find(params[:image_id])
    @document = Document.find(params[:document_id])
    @comment=Comment.create(:value=>annotation_hash['text'],:json=>annotation_json, :image_id=>@image.id, :isAnnotation=>true)
    render "comments/create"
  end

  def update

  end

  def destroy

  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:value, :reviewed)
    end
end
