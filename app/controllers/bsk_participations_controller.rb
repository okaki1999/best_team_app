class BskParticipationsController < ApplicationController

    def create
        @member = BskMember.find(params[:bsk_member_id]) 
        @participation = BskParticipation.create(bsk_member_id: @member.id)
        redirect_to bsk_members_path, notice: '参加しました。'
    end
    
    def destroy
        @member = BskMember.find(params[:bsk_member_id])
        @participation = BskParticipation.find_by(bsk_member_id: @member.id)
        @participation.destroy
        redirect_to bsk_members_path, notice: '参加を取り消しました。'
    end
    

end
