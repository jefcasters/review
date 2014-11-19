require 'json'
class AnnotationsController < ApplicationController

  before_action :authenticate_user!
  def index

  end

  def show

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

    @comment=Comment.create(:value=>annotation_hash['text'],:json=>aannotation_json,:druid=>params[:druid],:user_id=>current_user.id)
    num_annotations=Annotation.where(:druid=>params[:druid]).count

    # in the json response, we add in the number of annotations into the json so we can update the badge on the badge with the success handler
    respond_to do |format|
      format.xml  { render :xml => @annotation.to_xml }
      format.json { render :json=> @annotation.as_json.merge({'num_annotations'=>num_annotations}) }
      format.html { render :partial => "all", :locals=>{:annotations=>[@annotation]}}
    end

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
