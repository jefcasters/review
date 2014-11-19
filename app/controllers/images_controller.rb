class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    @images = Image.all
    respond_with(@images)
  end

  def show
    @document = Document.find(params[:document_id])
    @user = User.find(@document.user_id)
    @image = Image.find(params[:id])
    @comments = @image.comments

    #redirect_to user_document_image_path(@user, @document, @image)
  end

  def new
    @image = Image.new
    respond_with(@image)
  end

  def edit
  end

  def create
    if(current_user.admin)
      @document = Document.find(params[:document_id])
      @user = User.find(@document.user_id)
    else
      @user = current_user
    end

    @document = Document.find(params[:document_id])
    @image = @document.images.create(image_params)

    redirect_to user_document_path(@user, @document)
  end

  def update
    @image.update(image_params)
    respond_with(@image)
  end

  def destroy

    if(current_user.admin)
      @document = Document.find(params[:document_id])
      @user = User.find(@document.user_id)
    else
      @user = current_user
    end

    @document = Document.find(params[:document_id])
    @image = @document.images.find(params[:id])
    @image.destroy
    redirect_to user_document_path(@user, @document)
  end

  private
    def set_image
      @image = Image.find(params[:id])
    end

    def image_params
      params.require(:image).permit(:foto)
    end

    def document_params
      params.require(:image).permit(:image)
    end
end
