@raw_songs = ["Ты куда, голубь, ходил,\nКуда, сизый, улетал\nПо ельничкам, по березничкам,\nПо частому, по белому\nПо осинничкам.\nЯ ко девице ходил,\nЯ ко красной улетал\nПо ельничкам, по березничкам,\nПо частому, по белому\nПо осинничкам.\nКоя краше всех,\nКоя лучше всех.\nЯ ельничком,\nЯ березничком,\nПо частому, по белому\nПо осинничкам.\nИ белым она бела,\nИ румяным румяна.\nЯ ельничком,\nЯ березничком,\nПо частому, по белому\nПо осинничкам.\n", 
"Аклы ситса кулмәгемне\nЯкаларын кем уйган\nәй исеме Рәйхан\nкемнәр куйган\nСине лә куреп\nкем туйган\nәй исеме Рәйхан\nкемнәр куйган\nСине лә куреп\nкем туйган\nРәйхан бирде\nкулъяулыгы\nАлды биргән\nяулыгы\nәй алмады биргән\nяулыгы\nАлды йөрәгем\nсаулыгын\nАклы ситса кулмәгемне\nТабалмадым ишләрен\nәй гомерем буйларына\nРәйхан\nОныта алмасам\nнишләрем\nәй гомерем\nбуйларына сине\nОныталмасам\nнишләрем\n",
"Баай-баай, утуй, чыычааҕым!\nСүлбээн-илбээн сүүстээх,\nХолбоон-илбээн хоҥоруулаах,\nМунньан-тараан муруннаах,\nИлбээн-холбоон иэдэстээх,\nХомуйан-имийэн кулгаахтаах.\n",
"Руй-руй, бай-бай,\nЗолотая моя гора,\nКаменная моя стена.\nНоги твои обгонят оленя,\nПальцы твои проворнее белки,\nГлаза твои не проглядят глухаря.\nОхотничью добычу будешь доставлять возами,\nУлов будешь привозить плотами,\nБудешь играть в городе серебряными рюхами,\nВ лапту будешь играть золотым мячом.\nЧерез пять городков будешь перескакивать,\nНад шестью городками седьмой выбивать.\nТы, мое солнышко, как посредине неба мерцающая звездочка,\nНа ладонях ты лелеянный,\nТы как тень у окна,\nКак куколка на коленях,\nДля дома ты большая радость.\n"
]

@title_adj = ["Волшебная", "Крутая", "Невероятная", "Лучшая", "Супер", "Amazing", "Вау", "Чудесная", "Добрая", "Хорошая"]

@tags = [""]
def seed
  reset_db
  create_admin
  create_users
  create_profiles
  create_posts(15)
  create_comments(2..8)
  create_comment_replies(300)
  create_likes(3..10)
  # create_tags(2..7)
  create_followings(40)
end

def reset_db
  Rake::Task['db:drop'].invoke
  Rake::Task['db:create'].invoke
  Rake::Task['db:migrate'].invoke
end

def create_users
  i = 0

  10.times do
    user_data = {
      email: "user_#{i}@email.com",
      password: 'testtest'
    }

    user = User.create!(user_data)
    puts "Пользователь с id #{user.id} создан"

    i += 1
  end
end

def create_profiles
  avatars_directory = "app/assets/images/DefaultAvatars"
  avatars = Dir.entries(avatars_directory).reject { |f| File.directory? File.join(avatars_directory, f) || !f.match(/\.(png|jpg|jpeg|gif)$/i) }

  User.all.each_with_index do |user, index|
    random_avatar = avatars.sample
    avatar_path = File.join(avatars_directory, random_avatar)
    username = "user_#{index}"
    nickname = "nickname_#{index}"
    profile = Profile.create(username: username, about: create_mashup(3), user_id: user.id, login: nickname, avatar: File.open(avatar_path))
    if profile.valid?
      puts "Profile #{profile.id} for user #{profile.user.id} created"
    else
      puts "Error creating profile for user #{user.id}: #{profile.errors.full_messages.join(', ')}"
    end
  end
end


def create_admin

    user_data = {
      email: "admin@email.com",
      password: 'testtest',
      admin: true
    }

    user = User.create!(user_data)
    puts "Админ с id пользователя #{user.id} создан"

end

def create_title(adj)
  title = "#{adj} песня" 
end

def split_song_into_lines(song)
  return song.split("\n")
end

def generate_random_song(raw_songs)
  selected_song = raw_songs.sample
  song_lines = split_song_into_lines(selected_song)
  selected_lines = song_lines.sample(1)
  return selected_lines
end

def create_mashup(how_many_lines)
  @mashup = []
  how_many_lines.times do
    @mashup.concat(generate_random_song(@raw_songs))
  end
  @mashup = @mashup.join("\n").html_safe
 return @mashup
end

def create_posts(quantity)
  quantity.times do
    user = User.all.sample
    post = Post.create(title: "#{@title_adj.sample} народная песня", text: create_mashup(24), user_id: user.id)
    puts "Пост #{post.id} создан"
  end
end

def create_comments(quantity)
  Post.all.each do |post|
    quantity.to_a.sample.times do
      user = User.all.sample
      comment = Comment.create(post_id: post.id, body: create_mashup(2), user_id: user.id)
      puts "Комментарий #{comment.id} для поста #{comment.post.id} создан"
    end
  end
end

def create_likes(quantity)
  Post.all.each do |post|
    quantity.to_a.sample.times do
      user = User.all.sample
      like = Like.create(post_id: post.id, user_id: user.id)
      puts "Лайк #{like.id} для поста #{like.post.id} создан"
    end
  end
end

def create_comment_replies(quantity)
  quantity.times do
    user = User.all.sample
    comment = Comment.all.sample
    reply = comment.replies.create(post_id: comment.post_id, user_id: user.id, body: create_mashup(2))
    puts "Ответ на комментарий #{reply.id} для комментария #{comment.id} создан"
  end
end

def create_followings(quantity)
  quantity.times do
    puts "бля"
    followed = User.all.sample
    follower = User.all.sample

    following = Following.new(follower_id: follower.id, followed_id: followed.id)
    if following.save
      puts "Пользователь #{follower.id} подписан на #{followed.id}"
    else
    end
  end
end


# def create_attachments(quantity)
#   Post.all.each do |post|
#     rand(quantity).times do
#       attachment = Attachment.create(post_id: post.id, url: "уррраааа работает")
#       puts "Вложение #{attachment.id} для поста #{attachment.post.id} создано"
#     end
#   end
# end

def create_tags(quantity)
  i=0
  Post.all.each do |post|
    rand(quantity).times do
      tag_name = "тег#{i}"
      post.genre_list.add(tag_name)
      post.save
      i+=1
    end
    puts "Теги жанров для поста #{post.id} созданы"
  end
  # Post.all.each do |post|
  #   rand(quantity).times do
  #     tag_name = "тег#{i}"
  #     post.theme_list.add(tag_name)
  #     post.save
  #     i+=1
  #   end
  #   puts "Теги тем для поста #{post.id} созданы"
  # end
  # Post.all.each do |post|
  #   rand(quantity).times do
  #     tag_name = "тег#{i}"
  #     post.language_list.add(tag_name)
  #     post.save
  #     i+=1
  #   end
  #   puts "Теги языков для поста #{post.id} созданы"
  # end
  # Post.all.each do |post|
  #   rand(quantity).times do
  #     tag_name = "тег#{i}"
  #     post.nationality_list.add(tag_name)
  #     post.save
  #     i+=1
  #   end
  #   puts "Теги национальностей для поста #{post.id} созданы"
  # end
end

seed