class ContactsController < ApplicationController
    def index
        @contacts = Contact.where(user_id: current_user.id)
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
    end

    def destroy
    end

private
    def create_params
        params.require(:contact).permit(:user_id, :contact_type, :contact_title, :inquiry)
    end


end
