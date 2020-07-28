class SiteManagersController < ApplicationController
  def index
    @site_managers = policy_scope(SiteManager)
  end
end
