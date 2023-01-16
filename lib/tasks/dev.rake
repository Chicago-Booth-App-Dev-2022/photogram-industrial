task sample_data: :environment do
  p "Creating sample data"

  if Rails.env.development?
    
    Like.destroy_all
    Comment.destroy_all
    Photo.destroy_all
    FollowRequest.destroy_all
    User.destroy_all
  end

# Create users
  
  usernames = Array.new {Faker::Name.first_name}

  usernames << "matt"
  usernames << "haley"
  usernames << "jason"
  usernames << "michael"

  usernames.each do |username| 
    User.create(
      email: "#{username}@example.com",
      username: username.downcase,
      password: "password",
      private: [true, false].sample
    )
  end

  p "#{User.count} users have been created."

  users = User.all

# Create Follow Requests

  users.each do |first_user|
    users.each do |second_user|
      if rand < 0.75
        first_user.sent_follow_requests.create(
          recipient: second_user,
          status: FollowRequest.statuses.values.sample
        )
      end

      if rand < 0.75
        second_user.sent_follow_requests.create(
          recipient: first_user,
          status: FollowRequest.statuses.values.sample
        )
      end
    end
  end

p "#{FollowRequest.count} follow requests have been created"

# Create photos

  users.each do |user|
    photo = user.own_photos.create(
      caption: Faker::Games::ElderScrolls.city,
      image: "https://robohash.org/#{rand(9999)}"
    )
  
    user.followers.each do |follower|
      if rand < 0.5
        photo.fans << follower
      end

      if rand < 0.25
        photo.comments.create(
          body: Faker::Games::ElderScrolls.creature,
          author: follower
        )
      end
    end
  end
  


  p "#{Photo.count} photos have been created"
  p "#{Like.count} likes have been created"
  p "#{Comment.count} comments have been created"

end

# Create Likes

  #users.each do |user|
    #user.leaders.each do |leader|
      #leader.own_photos.each do |photo|
        #if rand < 0.20
          #photo.likes.create(
            #fan_id: user.id
          #)
        #end
      #end
    #end
  #end

  # p "#{Like.count} likes have been created"
