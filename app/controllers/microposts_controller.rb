class MicropostsController < ApplicationController
  before_action :signed_in_user,  only: [:create, :destroy]
  before_action :correct_user,    only: :destroy
  def create
  	@micropost = current_user.microposts.build(micropost_params)
  	if @micropost.save
  		flash[:success] = "Micropost Created"
  		redirect_to root_url
  	else
      @feed_items = []
  		render 'static_pages/home'
  	end
  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  def index
  end

  private

  	def micropost_params
  		# Use to filter out only needed params from hash
  		# avoiding SQL injection
  		params.require(:micropost).permit(:content)
  	end
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end