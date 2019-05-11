class Admin::TagsController < Admin::BaseController
  before_action :find_tag, only: [:update, :destroy]

  respond_to :html, :js

  def index
    @tags = ActsAsTaggableOn::Tag.category.page(params[:page])
    @tag  = ActsAsTaggableOn::Tag.category.new
  end

  def create
    @existing_tag = ActsAsTaggableOn::Tag.where(name: tag_params.first).first
    if @existing_tag
      @existing_tag.kind = "category"
      @existing_tag.save
    else
      ActsAsTaggableOn::Tag.category.create(tag_params)
    end
    redirect_to admin_tags_path
  end

  def destroy
    @tag.destroy
    redirect_to admin_tags_path
  end

  private

    def tag_params
      params.require(:tag).permit(:name)
    end

    def find_tag
      @tag = ActsAsTaggableOn::Tag.category.find(params[:id])
    end

end
