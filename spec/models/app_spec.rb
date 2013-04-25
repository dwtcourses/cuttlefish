require 'spec_helper'

describe App do
  describe "#smtp_password" do
    it "should create a password consisting of only letter and underscores" do
      app = App.create!(name: "Foo")
      app.smtp_password.should match /^[a-z_]+$/
    end

    it "should create a password that is different every time" do
      app1 = App.create!(name: "Foo")
      app2 = App.create!(name: "Bar")
      app1.smtp_password.should_not == app2.smtp_password
    end
  end

  describe "#name" do
    it "should allow upper and lower case letters, numbers, spaces and underscores" do
      App.new(name: "Foo12 Bar_Foo").should be_valid
    end

    it "should not allow other characters" do
      App.new(name: "*").should_not be_valid
    end
  end

  describe "#smtp_username" do
    it "should set the smtp_username based on the name when created" do
      app = App.create!(name: "Planning Alerts", id: 15)
      app.smtp_username.should == "planning_alerts_15"
    end

    it "should not change the smtp_username if the name is updated" do
      app = App.create!(name: "Planning Alerts", id: 15)
      app.update_attributes(name: "Another description")
      app.smtp_username.should == "planning_alerts_15"
    end
  end
end