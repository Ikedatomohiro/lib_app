class ContactsController < ApplicationController
    before_action :authenticate_user! # ログインしていないときはログインページに移動
      # application_helper.rbで定義
      before_action :set_setting_flg, only: [:edit, :show, :update]
    def index
        if current_user.admin_flg
            @contacts = Contact.all.order(created_at: "DESC")
        else
            @contacts = Contact.where(user_id: current_user.id).order(created_at: "DESC")
        end
        @setting_flg = true
    end

    def create
        @contact = Contact.new(create_params)
        @contact.save!
        @setting_flg = true
        redirect_to '/contacts/thanks'
    end

    def new

    end

    def edit
    end

    def show
    end

    def update
        contact = Contact.find_by(id: params[:id])
        contact.update(response: params[:contact][:response])
        render '/contacts/thanks'
    end

    def destroy
    end

private
    def create_params
        params.require(:contact).permit(:user_id, :contact_type, :contact_title, :inquiry)
    end


end
