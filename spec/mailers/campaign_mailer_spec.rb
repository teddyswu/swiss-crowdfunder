require "rails_helper"

RSpec.describe CampaignMailer, type: :mailer do
  describe "campaign_success" do
    let(:mail) { CampaignMailer.campaign_success }

    it "renders the headers" do
      expect(mail.subject).to eq("Campaign success")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "notify_comment" do
    let(:mail) { CampaignMailer.notify_comment }

    it "renders the headers" do
      expect(mail.subject).to eq("Notify comment")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
