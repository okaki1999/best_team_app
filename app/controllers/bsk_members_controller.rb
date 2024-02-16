class BskMembersController < ApplicationController
    before_action :set_member, only: [:show, :edit, :update, :destroy]
  
    def new
        @member = BskMember.new
    end

    def detail
        @members = BskMember.all
        if params[:id].present?
          @member = Member.find(params[:id])
        else
          # 何かしらのデフォルト処理やエラー処理を実装
          # 例: @member = Member.first
        end
        @match = Match.new
    end

    def index
        @members = BskMember.all
        if params[:id].present?
          @member = BskMember.find(params[:id])
        else
          # 何かしらのデフォルト処理やエラー処理を実装
          # 例: @member = Member.first
        end
        @match = BskMatch.new
    end

    def create
        @member = BskMember.new(member_params)
        
        if @member.save
            redirect_to bsk_members_path, notice: '新しいメンバーが作成されました。'
        else
            redirect_to action: :new
        end
    end

    def edit
        @member = BskMember.find(params[:id])

    end

    def update
        @member = BskMember.find(params[:id])
        if @member.update(member_params)
          redirect_to detail_bsk_members_path,notice: "更新に成功しました。"
        else
          render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @member = BskMember.find(params[:id])
        @member.destroy
        redirect_to root_path, notice: 'Member was successfully deleted.'
    end

  
    private

  
    def update_rating_based_on_result(result)
        winner, loser = result.split('、')
        winner_member = BskMember.find_by(name: winner)
        loser_member = BskMember.find_by(name: loser)
  
        winner_rate = winner_member.rating
        loser_rate = loser_member.rating
  
        # calculatePointメソッドはレーティングの差から新しいポイントを計算するものと仮定
        new_rating_for_winner = calculatePoint(winner_rate, loser_rate)
        new_rating_for_loser = calculatePoint(loser_rate, winner_rate)
  
        # データベースの更新
        winner_member.update(scoring_rate: new_rating_for_winner)
        loser_member.update(scoring_rate: new_rating_for_loser)
    end
  
    def member_params
        params.require(:bsk_member).permit(:name, :scoring_rate, member_reslt: [])
    end
  
    def set_member
        @member = BskMember.find(params[:id])
    end
end
