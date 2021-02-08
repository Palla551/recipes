module ApplicationHelper

  def  image_for(user, options = {size: 80})
     image_id = Digest::MD5::hexdigest(user.email.downcase)
     size = options[:size]
     image_url = "https://secure.gravatar.com/avatar/#{image_id}?=s#{size}"
     #https://www.w3schools.com/howto/img_avatar.png
     image_tag(image_url, alt: user.name, class: "rounded")
  end

end
