require "rails_helper"

RSpec.describe ContactMailer, type: :mailer do
  it "should be able to send an email" do
    contact = { name: 'Moi', email: 'test@gmail.com', description: 'Ceci est ma raison' }
    expect { ContactMailer.contact(contact).deliver_now }.to change { ContactMailer.deliveries.count }.by(1)
  end

  it "should not be able to send an email if data sent are not exactly what is expected" do
    contact = { email: 'camarchepas@gmail.com' }
    expect { ContactMailer.contact(contact).deliver_now }.not_to(change { ContactMailer.deliveries.count })
  end
end
