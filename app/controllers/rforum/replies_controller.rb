# coding: utf-8
class  Rforum::RepliesController <  Rforum::RforumController

  load_and_authorize_resource :reply,:class=>"Rforum::Reply"
  before_filter :find_topic
  def create

    @reply = @topic.replies.build(params[:reply]) #what is this for?

    @reply.user_id = current_user.id
    if @reply.save
      current_user.read_topic(@topic)
      @msg = t("topics.reply_success")
    else
      @msg = @reply.errors.full_messages.join("<br />")
    end
  end

  def edit
    @reply = Rforum::Reply.find(params[:id])
    drop_breadcrumb(t("menu.topics"), rforum.topics_path)
    drop_breadcrumb t("reply.edit_reply",:use_route => :rforum)
  end

  def update
    @reply = Rforum::Reply.find(params[:id])

    if @reply.update_attributes(params[:reply])
      redirect_to(topic_path(@reply.topic_id), :notice => '回帖更新成功.')
    else
      render :action => "edit"
    end
  end

  protected

  def find_topic
    @topic = Rforum::Topic.find(params[:topic_id])
  end

end
