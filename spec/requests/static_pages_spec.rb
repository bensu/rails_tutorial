require 'spec_helper'
include ApplicationHelper

describe "StaticPages" do

	let(:base_title) { "Ruby on Rails Tutorial Sample App" }

	subject { page }

	shared_examples_for "all static pages" do
		it { should have_selector('h1', text: heading) }
		it { should have_title(full_title(page_title)) }
	end
	describe "Home Page" do
		before { visit root_path }
		let(:heading) { 'Sample App'}
		let(:page_title) { '' }
		it_should_behave_like "all static pages"
		it { should_not have_title(" | Home") }
	
		describe "for signed-in users" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
				FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
				sign_in user
				visit root_path
			end
			describe "follower/following counts" do
				let(:other_user) { FactoryGirl.create(:user) }
				before do
					other_user.follow!(user)
					visit root_path
				end
				it { should have_link("0 following", href: following_user_path(user)) }
				it { should have_link("1 followers", href: followers_user_path(user)) }
			end

			it "should render the user's feed" do
				user.feed.each do |item|
					expect(page).to have_selector("li##{item.id}", text: item.content)
				end
			end
			it { should have_content("view my profile") }
			# JS generated content can't be tested from rspec?
=begin
it { should have_content("#{user.microposts.count} microposts") }

it { should have_content("140 characters left") }
describe "should count characters while writing" do
	before { fill_in "Compose new micropost...", with: "a" }
	it { should have_content("139 characters left")}
end
=end
		end
	end

	describe "Help Page" do
		before { visit help_path }
		let(:heading) { 'Help' }
		let(:page_title) { 'Help' }
		it_should_behave_like "all static pages"
	end

	describe "About Page" do
		before { visit about_path }
		let(:heading) { 'About' }
		let(:page_title) { 'About' }
		it_should_behave_like "all static pages"
	end

	describe "Contact Page" do
		before { visit contact_path }
		let(:heading) { 'Contact' }
		let(:page_title) { 'Contact' }
		it_should_behave_like "all static pages"
	end

	it "should have the right links on the layout" do
	    visit root_path
	    click_link "About"
	    expect(page).to have_title(full_title("About"))
	    click_link "Help"
	    expect(page).to have_title(full_title("Help"))
	    click_link "Contact"
	    expect(page).to have_title(full_title("Contact"))
	    click_link "Home"
	    expect(page).to have_title(full_title(''))
	    click_link "Sign up now!"
	    expect(page).to have_title(full_title("Sign Up"))
	    click_link "sample app"
	    expect(page).to have_title(full_title(''))
	end
end
