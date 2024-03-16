class ParticipationsController < ApplicationController
  def create
      @member = Member.find(params[:member_id]) 
      @participation = Participation.create(member_id: @member.id)
      redirect_to members_path, notice: '参加しました。'

  end
  
  def destroy
    @participation = Participation.find_by(member_id: params[:member_id])
    if @participation
      @participation.destroy
      # 削除が成功した場合の処理
      redirect_to members_path
    else
      # 削除する参加記録が見つからない場合の処理
    end
  end
end
