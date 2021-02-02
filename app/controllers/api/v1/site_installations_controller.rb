class Api::V1::SiteInstallationsController < Api::V1::BaseController
  def index
    # Renvois la liste des sous-traitants qui n'ont pas encore été sélectionnés
    if params[:ppsps_id] == ''
      @site_installations = policy_scope(SiteInstallation.all)
      authorize @site_installations
    else
      selected_site_installations = SelectedInstallation.where(ppsp_id: params[:ppsps_id])
      @site_installations = policy_scope(SiteInstallation).where.not(id: selected_site_installations.map(&:site_installation_id))
      authorize @site_installations
    end
  end

  def selected_site_installations
    # Renvois la liste des sous-traitants aui ont déjà été sĺectionnés
    selected_site_installations = SelectedInstallation.where(ppsp_id: params[:ppsps_id])
    @site_installations = policy_scope(SiteInstallation).where(id: selected_site_installations.map(&:site_installation_id))
    authorize @site_installations
  end

  def destroy
    @selected_site_installation = SelectedInstallation.where(ppsp_id: params[:ppsps_id], site_installation_id: params[:id]).first
    authorize @selected_site_installation
    @selected_site_installation.destroy
    head :no_content
  end
end
