module Rforum
  class Engine < ::Rails::Engine
    
        initializer 'Rforum::Application.helper' do |app|
      ActionView::Base.send :include, Rforum::NotesHelper,Rforum::TopicsHelper,Rforum::LikesHelper
      #  ActionController::Base .send :include,  ApplicationHelper,UsersHelper
    end
    isolate_namespace Rforum
  end
end
