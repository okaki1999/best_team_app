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
  
    def destroy
        @member = Member.find(params[:id])
        @member.destroy
        redirect_to root_path, notice: 'Member was successfully deleted.'
    end
  
    private
  
    def member_params
      params.require(:member).permit(:name, :rating)
    end
  
    def set_member
      @member = Member.find(params[:id])
    end
  end
  