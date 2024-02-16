class BskMatchesController < ApplicationController
    
    def show
        @match = BskMatch.find(params[:id])
        puts @match.inspect
        @members = @match.bsk_members
    end

    def index
        @matchs = BskMatch.all
    end

    def new
        @match = BskMatch.new
    end

    def create
        @match = BskMatch.new(match_params)
        p match_params.inspect
        match_id = nil
      
        @members = BskMember.all
        @member_ids = @members.select(&:bsk_already_participation?).map(&:id)
        p @member_ids.inspect
      
       
        begin
            # トランザクションを開始
            ActiveRecord::Base.transaction do
                # まずは試合を保存
                @match.save!
                match_id = @match.id
                p @match.inspect
                # 試合が保存されたら、各メンバーを試合に参加させる
                @member_ids.each do |member|
                    @enrollment = BskEnrollment.new(bsk_member_id: member, bsk_match_id: @match.id)
                    @enrollment.save!
                end
                # リダイレクト時に試合のIDが必要なので保存後にIDを取得
                
                p @enrollment.inspect
            end
            
        rescue => exception
            p exception
            # 試合の保存に失敗した場合の処理
            # エラーメッセージを表示したり、必要に応じて処理を行う
            return redirect_to action: :new
        end
        
        # リダイレクト
        return redirect_to bsk_match_path(match_id), notice: '新しい試合が作成されました。'
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
            winner_avg_rating = (BskMember.find(member_ids.first).rating + BskMember.find(member_ids.second).rating) / 2.0
            loser_avg_rating = (BskMember.find(member_ids.fourth).rating + BskMember.find(member_ids.third).rating) / 2.0
  
            # K 値の定義
            k = 32
  
            # Elo レーティングの変化を計算
            rating_change = k / (10 ** ((winner_avg_rating - loser_avg_rating) / 400.0) + 1)
  
            # レーティングの変化をクランプ
            rating_change = clamp((rating_change + 0.5).ceil, 2, 32)
  
            # メンバーのレーティングを更新
            BskMember.where(id: [member_ids.first, member_ids.second]).update_all("rating = rating + #{rating_change}")
            BskMember.where(id: [member_ids.fourth, member_ids.third]).update_all("rating = rating - #{rating_change}")
        end
        
    end
  

    def destroy
        @match = BskMatch.find(params[:id])
        @match.destroy
        redirect_to matches_path, notice: 'Member was successfully deleted.'
    end
    
    private

    def match_params
        params.require(:bsk_match).permit(:coat)
    end
end
