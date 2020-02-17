class ContactsController < ApplicationController
    def index
        if current_user.admin_flg
            @contacts = Contact.all.order(created_at: "DESC")
        else
            @contacts = Contact.where(user_id: current_user.id).order(created_at: "DESC")
        end
    end

    def create
        @contact = Contact.new(create_params)
        @contact.save!
    end

    def new

    end

    def edit
    end

    def show
    end

    def update
        contact = Contact.find_by(id: params[:id])
        contact.update(response: params[:response])
        render '/contacts/thanks'
    end

    def destroy
    end

private
    def create_params
        params.require(:contact).permit(:user_id, :contact_type, :contact_title, :inquiry)
    end


end
