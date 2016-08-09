DatabaseCleaner.clean_with(:truncation)
FileUtils.rm_rf('public/uploads/.')

FactoryGirl.create :user, email: 'admin@example.com', password: 'password', first_name: 'Admin', last_name: ''
FactoryGirl.create :user, email: 'user@example.com', password: 'password', first_name: 'User', last_name: 'Test'
