class Admin::SettingsController < Admin::BaseController

  def index
    all_settings = Setting.all.group_by { |setting| setting.type }
    @configuration_settings = []
    @feature_settings = []
    @participation_processes_settings = []
    @map_configuration_settings =[]
    unless all_settings.nil?
      unless all_settings["configuration"].nil?
        @configuration_settings = all_settings["configuration"]
      end
      unless all_settings["feature"].nil?
        @feature_settings = all_settings["feature"]
      end
      unless all_settings["process"].nil?
        @participation_processes_settings = all_settings["process"]
      end
      unless all_settings["map"].nil?
        @map_configuration_settings = all_settings["map"]
      end
    end
  end

  def update
    @setting = Setting.find(params[:id])
    @setting.update(settings_params)
    redirect_to request.referer, notice: t("admin.settings.flash.updated")
  end

  def update_map
    Setting["map.latitude"] = params[:latitude].to_f
    Setting["map.longitude"] = params[:longitude].to_f
    Setting["map.zoom"] = params[:zoom].to_i
    redirect_to admin_settings_path, notice: t("admin.settings.index.map.flash.update")
  end

  private

    def settings_params
      params.require(:setting).permit(:value)
    end

end
