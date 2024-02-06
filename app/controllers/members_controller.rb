class MembersController < ApplicationController
    before_action :set_member, only: [:show, :edit, :update, :destroy]
  
    def new
        @member = Member.new
    end

    def create
        @member = Member.new(member_params)
        
        if @member.save
            redirect_to root_path, notice: '新しいメンバーが作成されました。'
        else
            redirect_to action: :new
        end
    end

    def edit
        @member = Member.find(params[:id])

    end

    def update
        @member = Member.find(params[:id])
        if @member.update(member_params)
          redirect_to root_path,notice: "更新に成功しました。"
        else
          render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @member = Member.find(params[:id])
        @member.destroy
        redirect_to root_path, notice: 'Member was successfully deleted.'
    end

  
    private

  
    def update_rating_based_on_result(result)
        winner, loser = result.split('、')
        winner_member = Member.find_by(name: winner)
        loser_member = Member.find_by(name: loser)
  
        winner_rate = winner_member.rating
        loser_rate = loser_member.rating
  
        # calculatePointメソッドはレーティングの差から新しいポイントを計算するものと仮定
        new_rating_for_winner = calculatePoint(winner_rate, loser_rate)
        new_rating_for_loser = calculatePoint(loser_rate, winner_rate)
  
        # データベースの更新
        winner_member.update(rating: new_rating_for_winner)
        loser_member.update(rating: new_rating_for_loser)
    end
  
    def member_params
        params.require(:member).permit(:name, :rating, member_reslt: [])
    end
  
    def set_member
        @member = Member.find(params[:id])
    end
end
  