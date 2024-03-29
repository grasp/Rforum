# coding: utf-8
class Rforum::PagesController < Rforum::RforumController

  authorize_resource :page,:class=>"Rforum::Page"

  before_filter :init_base_breadcrumb
  before_filter :set_menu_active

  def index
    set_seo_meta("Wiki")
    drop_breadcrumb("索引",:use_route => :rforum)
  end

  def recent
    @pages = Rforum::Page.recent.paginate(:page => params[:page], :per_page => 30)
    set_seo_meta t("pages.wiki_index")
    drop_breadcrumb(t("common.index"),:use_route => :rforum)
  end

  def show
    @page = Rforum::Page.find_by_slug(params[:id])
    if @page.nil?
      if current_user
        redirect_to new_page_path(:title => params[:id]), :notice => "Page not Found, Please create a new page"
      else
        render_404
      end
    else
      set_seo_meta("#{@page.title} - Wiki")
      drop_breadcrumb("查看 #{@page.title}",:use_route => :rforum)
    end
  end

  def new
    @page = Rforum::Page.new
    @page.slug = params[:title]
    set_seo_meta t("pages.new_wiki_page")
    drop_breadcrumb(t("pages.new_wiki_page"),:use_route => :rforum)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page }
    end
  end

  def edit
    @page = Rforum::Page.find(params[:id])
    set_seo_meta t("pages.edit_wiki_page")
    drop_breadcrumb(t("common.edit"),:use_route => :rforum)
  end

  def create
    @page = Rforum::Page.new(params[:page])
    @page.user_id = current_user.id
    @page.version_enable = true

    if @page.save
      redirect_to rforum.page_path(@page.slug), notice: t("common.create_success")
    else
      render action: "new"
    end
  end

  def update
    @page = Rforum::Page.find(params[:id])
    @page.version_enable = true
    @page.user_id = current_user.id

    if @page.update_attributes(params[:page])
      redirect_to rforum.page_path(@page.slug), notice: t("common.update_success")
    else
      render action: "edit"
    end
  end

protected

  def set_menu_active
    @current = @current = ['/wiki']
  end

  def init_base_breadcrumb
    drop_breadcrumb("Wiki", rforum.pages_path)
  end
end
