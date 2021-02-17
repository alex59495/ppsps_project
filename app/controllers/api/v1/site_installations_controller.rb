class Api::V1::SiteInstallationsController < Api::V1::BaseController
  def index
    # Renvoie la liste des site_installation qui n'ont pas encore été sélectionnés
    if params[:ppsps_id] == ''
      @site_installations = policy_scope(SiteInstallation)
      authorize @site_installations
    else
      selected_site_installations = SelectedInstallation.where(ppsp_id: params[:ppsps_id])
      @site_installations = policy_scope(SiteInstallation).where.not(id: selected_site_installations.map(&:site_installation_id))
      authorize @site_installations
    end
  end

  def selected_site_installations
    # Renvois la liste des site_installation aui ont déjà été sĺectionnés
    selected_site_installations = SelectedInstallation.where(ppsp_id: params[:ppsps_id])
    @site_installations = policy_scope(SiteInstallation).where(id: selected_site_installations.map(&:site_installation_id))
    authorize @site_installations
  end

  def destroy_selected_installations
    @selected_site_installation = SelectedInstallation.where(ppsp_id: params[:ppsps_id], site_installation_id: params[:installation_id]).first
    authorize @selected_site_installation
    @selected_site_installation.destroy
    head :no_content
  end
end
