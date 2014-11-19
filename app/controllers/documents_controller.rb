class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  before_action :posso, only: [:show]
  respond_to :html
  before_action :authenticate_user!

  def find_my_root
    if(current_user.admin)
      redirect_to users_path(@user)
    else
      @user = current_user
      redirect_to user_documents_path(@user)
    end
  end

  def index
    @title ="Documents"
    if(current_user.admin)
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end

    @documents = @user.documents

    @images = Array.new
    @documents.each do |document|
      @images.push document.images.last
    end

    respond_with(@user,@documents,@images)
  end

  def show
    @title ="Document name"
    @document = Document.find(params[:id])
    @user = User.find(params[:user_id])
    @images = @document.images.order('created_at DESC')
    respond_with(@user,@document)


  end

  def new
    @document = Document.new
    @user = User.find(params[:user_id])
    respond_with(@document)
  end

  def edit
  end

  def create
    # @user = User.find(params[:user])
    if(current_user.admin)
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end

    @document = Document.new(document_params)
    @document.user_id = params[:user_id]
    @document.save
    respond_with(@user,@document)
  end

  def update
    @document.update(document_params)
    respond_with(@document)
  end

  def destroy
    @user = User.find(params[:user_id])
    @document.destroy
    redirect_to user_documents_path(@user)
  end

  private
    def set_document
      @document = Document.find(params[:id])
    end

    def document_params
      params.require(:document).permit(:title, :image)
    end

    def posso
      @document = Document.find(params[:id])
      redirect_to root_path unless @document.user_id == current_user.id || current_user.admin
    end
end
