class UserMailer < ActionMailer::Base
  default from: "sableng@sableng.com"

  def welcome_email(user, story)
    @user = user
    @url  = "http://example.com/login"
    @story = story
    mail(:to => ["iwan.piliang@yahoo.com","w.yunnal@gmail.com"], :subject => "#{@user.profile.name} baru bikin artikel")
  end
end
