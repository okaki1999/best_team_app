class MatchesController < ApplicationController

    def show
        @match = Match.find(params[:id])
        puts @match.inspect
        @members = @match.members

        
    end

    def index
        @matchs = Match.all
    end

    def new
        @match = Match.new
    end

    def create
        @match = Match.new(match_params)
        p match_params.inspect
      
        @members = Member.all
        @member_ids = @members.select(&:already_participation?).map(&:id)
      
        # トランザクションを開始
        ActiveRecord::Base.transaction do
            # まずは試合を保存
            if @match.save
                # 試合が保存されたら、各メンバーを試合に参加させる
                @member_ids.each do |member|
                    @enrollment = Enrollment.new(member_id: member, match_id: @match.id)
                    @enrollment.save!
                end
                # リダイレクト時に試合のIDが必要なので保存後にIDを取得
                match_id = @match.id
            else
                # 試合の保存に失敗した場合の処理
                # エラーメッセージを表示したり、必要に応じて処理を行う
                redirect_to action: :new
            return
            end
      
            # リダイレクト
            redirect_to match_path(match_id), notice: '新しい試合が作成されました。'
        end
    end

    def clamp(point, min, max)
        if point < min
            return min
        elsif max < point
            return max
        else
            return point
        end
    end
  
    def update
        params[:member_reslt].each do |result|
            member_ids = result.scan(/\d+/).map(&:to_i)
  
            # メンバーの平均レーティングを計算
            winner_avg_rating = (Member.find(member_ids.first).rating + Member.find(member_ids.second).rating) / 2.0
            loser_avg_rating = (Member.find(member_ids.fourth).rating + Member.find(member_ids.third).rating) / 2.0
  
            # K 値の定義
            k = 32
  
            # Elo レーティングの変化を計算
            rating_change = k / (10 ** ((winner_avg_rating - loser_avg_rating) / 400.0) + 1)
  
            # レーティングの変化をクランプ
            rating_change = clamp((rating_change + 0.5).ceil, 2, 32)
  
            # メンバーのレーティングを更新
            Member.where(id: [member_ids.first, member_ids.second]).update_all("rating = rating + #{rating_change}")
            Member.where(id: [member_ids.fourth, member_ids.third]).update_all("rating = rating - #{rating_change}")
        end
    end
  

    def destroy
        @match = Match.find(params[:id])
        @match.destroy
        redirect_to root_path, notice: 'Member was successfully deleted.'
    end
    
    private

    def match_params
        params.require(:match).permit(:coat, :member_id)
    end
end
