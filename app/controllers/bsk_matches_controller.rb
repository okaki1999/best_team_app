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
        if params[:member_scoring_rate].present?
          params[:member_scoring_rate].each do |member_id, new_scoring_rate|
            member = BskMember.find(member_id)
            new_scoring_rate = new_scoring_rate.to_i
            member.update(scoring_rate: member.scoring_rate + new_scoring_rate, total_match: member.total_match + 1)
          end
        end
      end
  

    def destroy
        @match = BskMatch.find(params[:id])
        @match.destroy
        redirect_to bsk_matches_path, notice: 'Member was successfully deleted.'
    end
    
    private

    def match_params
        params.require(:bsk_match).permit(:coat)
    end
end
