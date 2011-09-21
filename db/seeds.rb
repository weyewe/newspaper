admin = User.create :email =>"admin@gmail.com", 
  :password => "admin1234",
  :password_confirmation => "admin1234"
  
writer = User.create :email => "writer@gmail.com",
  :password => "writer1234",
  :password_confirmation => "writer1234"
  
editor = User.create :email => "editor@gmail.com",
  :password => "editor1234",
  :password_confirmation => "editor1234"




admin_role = Role.create :name => "admin"
writer_role = Role.create :name => "writer"
editor_role = Role.create :name => "editor"

admin.roles << admin_role
admin.save

writer.roles << writer_role
writer.save

editor.roles << editor_role
editor.save


for user in User.all
  user.approved = true 
  user.save
end

Category.create :name => "Top Sableng"
Category.create :name => "Paling Sableng"
#  sum == 8 
Category.create :name => "Wiro Sableng"
Category.create :name => "Ekonomi Sableng"
Category.create :name => "Hukum Sableng"
Category.create :name => "Politik Sableng"
Category.create :name => "Teknologi Sableng"
Category.create :name => "Usaha Sableng"
# sum  =4 *  8 == 32

# we need at least 40 news daily T__T fuck
