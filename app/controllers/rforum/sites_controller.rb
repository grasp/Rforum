# coding: UTF-8
class Rforum::SitesController < Rforum::RforumController
  load_and_authorize_resource

  def index
    @site_nodes = Rforum::SiteNode.all.includes(:sites).desc('sort')
    drop_breadcrumb(t("menu.sites"))
    set_seo_meta("Ruby #{t("menu.sites")}")
  end

  def new
    @site = Rforum::Site.new
    drop_breadcrumb(t("menu.sites"), sites_path)
    drop_breadcrumb(t("common.create"))
  end

  def create
    @site = Rforum::Site.new(params[:site])
    @site.user_id = current_user.id
    if @site.save
      redirect_to(sites_path, :notice => '提交成功。谢谢。')
    else
      drop_breadcrumb(t("menu.sites"), sites_path)
      drop_breadcrumb(t("common.create"))
      render :action => "new"
    end
  end

end
