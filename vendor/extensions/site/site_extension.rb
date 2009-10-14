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
      
      preference :site_name, :string, :default => '星尚商城 :: 会员特供'
      preference :site_url, :string, :default => 'mall.enjoyoung.cn'
      preference :enable_mail_delivery, :boolean, :default => true
      preference :mail_host, :string, :default => 'mail.enjoyoung.cn'
      preference :mail_domain, :string, :default => 'mail.enjoyoung.cn'
      preference :mail_port, :integer, :default => 25
      preference :mail_auth_type, :string, :default => 'login'
      preference :smtp_username, :string, :default => 'enjoyoung_mailer@enjoyoung.cn'
      preference :smtp_password, :string, :default => "1q!2w@3e#"
      preference :secure_connection_type, :string, :default => 'None'
      preference :mails_from, :string, :default => '星尚网站管理员'
      preference :mail_bcc, :string, :default => "alex.chien@enjoyoung.cn"
      preference :order_from, :string, :default => "enjoyoung_mailer@enjoyoung.cn"
      preference :order_bcc, :string, :default => "alex.chien@enjoyoung.cn"
      preference :store_cc, :boolean, :default => false
      preference :store_cvv, :boolean, :default => false
      preference :default_locale, :string, :default => 'zh-CN'
      preference :allow_locale_switching, :boolean, :default => false
      preference :default_country_id, :integer, :default => 41 #China
      preference :allow_backorders, :boolean, :default => true
      preference :allow_backorder_shipping, :boolean, :default => false # should only be true if you don't need to track inventory
      preference :show_descendents, :boolean, :default => true
      preference :show_zero_stock_products, :boolean, :default => true
      preference :orders_per_page, :integer, :default => 25   
      preference :admin_products_per_page, :integer, :default => 20 
      preference :products_per_page, :integer, :default => 20
      preference :default_tax_category, :string, :default => nil # Use the name (exact case) of the tax category if you wish to specify
      
      preference :stylesheets, :string, :default => 'compiled/screen,compiled/site'
      preference :logo, :string, :default => "/images/logo.png"
      preference :allow_ssl_in_production, :boolean, :default => false
      preference :allow_ssl_in_development_and_test, :boolean, :default => false
      preference :google_analytics_id, :string, :default => 'UA-10295365' # Replace with real Google Analytics Id 
      preference :allow_guest_checkout, :boolean, :default => true 
      preference :alternative_billing_phone,  :boolean, :default => false # Request extra phone for bill addr
      preference :alternative_shipping_phone, :boolean, :default => false # Request extra phone for ship addr
      preference :shipping_instructions,      :boolean, :default => true # Request instructions/info for shipping 
      preference :show_price_inc_vat, :boolean, :default => false 
      preference :auto_capture, :boolean, :default => true # automatically capture the creditcard (as opposed to justjust authorize and capture later)
      
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
