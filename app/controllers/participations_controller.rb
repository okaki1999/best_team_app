class ParticipationsController < ApplicationController
  def create
      @member = Member.find(params[:member_id]) 
      @participation = Participation.create(member_id: @member.id)
      redirect_to members_path, notice: '参加しました。'

  end
  
    def destroy
      @member = Member.find(params[:member_id])
      @participation = Participation.find_by(member_id: @member.id)
      @participation.destroy
      redirect_to members_path, notice: '参加を取り消しました。'
    end
end
