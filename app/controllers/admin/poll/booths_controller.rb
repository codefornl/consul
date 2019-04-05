class Admin::Poll::BoothsController < Admin::Poll::BaseController
  load_and_authorize_resource class: "Poll::Booth"

  def index
    @title = I18n.t("admin.menu.poll_booths")
    @booths = @booths.order(name: :asc).page(params[:page])
  end

  def show
  end

  def new
  end

  def create
    if @booth.save
      redirect_to admin_booths_path, notice: t("flash.actions.create.poll_booth")
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @booth.update(booth_params)
      redirect_to admin_booth_path(@booth), notice: t("flash.actions.update.poll_booth")
    else
      render :edit
    end
  end

  def available
    @title = I18n.t("admin.menu.poll_shifts")
    @booths = Poll::Booth.available.order(name: :asc).page(params[:page])
    render :index
  end

  private

    def booth_params
      params.require(:poll_booth).permit(:name, :location)
    end

end
