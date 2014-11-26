require 'rails_helper'

RSpec.describe "Projects", :type => :request do
  subject { page }

  describe "should be" do
    # let(:user) { create(:user) }
    # before do
    #   login_as user
    #   visit root_path
    # end

    #it { expect(user.name).to eq("Persons_1") }

    it { expect(page).to have_selector("title", text: "BodyStats") }
    #it { should have_title('FreeClassifieds') }
    #it { should have_selector('h3', text:" #{user.full_name}") }

    # describe "followers" do
    #   before do
    #     sign_in other_user
    #     visit followers_user_path(other_user)
    #   end

    #   it { should have_title(full_title('Followers')) }
    #   it { should have_selector('h3', text: 'Followers') }
    #   it { should have_link(user.name, href: user_path(user)) }
    # end
  end
end
