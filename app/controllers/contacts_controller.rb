class ContactsController < ApplicationController

  def index
    user = User.find(params[:user_id])
    render json: [user.contacts, user.shared_contacts]
  end

  def create
    contact = Contact.new(contact_params)
    if contact.save
      render json: contact
    else
      render json: contact.errors.full_messages, status: :unproccessable_entity
    end
  end

  def destroy
    contact = Contact.find(params[:id])
    if Contact.destroy(contact)
      render json: contact
    else
      raise "whatever"
    end
  end

  def show
    render json: Contact.find(params[:id])
  end

  def update
    if Contact.update(params[:id], contact_params)
      render json: Contact.find(params[:id])
    else
      render json: contact.errors.full_messages, status: :unproccessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :user_id)
  end
end
