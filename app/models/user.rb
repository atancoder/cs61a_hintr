require 'securerandom'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true
  
  def send_email()
    # assuming the user has been created,
    # sends an email to the user's email with username and password
    require 'mail'
    
    Mail.defaults do
      delivery_method :smtp, {
        :address => 'smtp.gmail.com',
        :port => '587',
        :user_name => 'hintr.app.noreply@gmail.com',
        :password => 'hintrapp169',
        :authentication => :plain,
        :enable_starttls_auto => true
      } 
    end
    user = self
    mail = Mail.new do
      from     'do-not-reply@hintr.app.com'
      to       user.email
      # to       'jaysid95@berkeley.edu'
      subject  'Welcome to cs61a Hintr!'
      
      text_part do
        body  "Welcome to hintr!\n" + 
              "Your login is: " + user.email + "\n" + 
              "Your password is: " + user.password + "\n" + 
              "Make sure to change your password and set your name when you first log in.\n"+
              "Login at: https://cs61a-hintr.herokuapp.com"
      end
      
    end
    mail.deliver!
  end
  
  def self.add_email(email_list)
    # takes in an email
    # returns success of user creation
    password = SecureRandom.urlsafe_base64(6)
    name = ''
    #Check if email is already being used
    user = User.create({:name=>name, :email => email, :password => password})
    if user.id
      #send the email
      return true
    else
      return false 
    end
  end
end
