class HomeController < ApplicationController
  def index
    @members = Member.all
    if params[:id].present?
      @member = Member.find(params[:id])
    else
      # 何かしらのデフォルト処理やエラー処理を実装
      # 例: @member = Member.first
    end
    @match = Match.new
    
    
  end

  def create
    @match = Match.new(match_params)

    if @match.save
      redirect_to match_path(@match), notice: '新しい試合が作成されました。'
    else
      render :new
    end
  end

  private

  def match_params
    params.require(:match).permit(:coat, :member_id)
  end
end

