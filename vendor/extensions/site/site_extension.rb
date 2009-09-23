# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class SiteExtension < Spree::Extension
  version "1.0"
  description "Default mall site extension"
  url "http://mall.enjoyoung.cn/"

  # Please use site/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end
  
  def activate
    
    AppConfiguration.class_eval do
      preference :stylesheets, :string, :default => "compiled/screen,compiled/site"
      preference :logo, :string, :default => "/images/logo.jpg"
    end

    # Add your extension tab to the admin.
    # Requires that you have defined an admin controller:
    # app/controllers/admin/yourextension_controller
    # and that you mapped your admin in config/routes

    #Admin::BaseController.class_eval do
    #  before_filter :add_yourextension_tab
    #
    #  def add_yourextension_tab
    #    # add_extension_admin_tab takes an array containing the same arguments expected
    #    # by the tab helper method:
    #    #   [ :extension_name, { :label => "Your Extension", :route => "/some/non/standard/route" } ]
    #    add_extension_admin_tab [ :yourextension ]
    #  end
    #end

    # make your helper avaliable in all views
    # Spree::BaseController.class_eval do
    #   helper YourHelper
    # end
  end
end
