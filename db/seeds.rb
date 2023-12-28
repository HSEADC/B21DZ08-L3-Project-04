@raw_songs = ["Ты куда, голубь, ходил,\nКуда, сизый, улетал\nПо ельничкам, по березничкам,\nПо частому, по белому\nПо осинничкам.\nЯ ко девице ходил,\nЯ ко красной улетал\nПо ельничкам, по березничкам,\nПо частому, по белому\nПо осинничкам.\nКоя краше всех,\nКоя лучше всех.\nЯ ельничком,\nЯ березничком,\nПо частому, по белому\nПо осинничкам.\nИ белым она бела,\nИ румяным румяна.\nЯ ельничком,\nЯ березничком,\nПо частому, по белому\nПо осинничкам.\n", 
"Аклы ситса кулмәгемне\nЯкаларын кем уйган\nәй исеме Рәйхан\nкемнәр куйган\nСине лә куреп\nкем туйган\nәй исеме Рәйхан\nкемнәр куйган\nСине лә куреп\nкем туйган\nРәйхан бирде\nкулъяулыгы\nАлды биргән\nяулыгы\nәй алмады биргән\nяулыгы\nАлды йөрәгем\nсаулыгын\nАклы ситса кулмәгемне\nТабалмадым ишләрен\nәй гомерем буйларына\nРәйхан\nОныта алмасам\nнишләрем\nәй гомерем\nбуйларына сине\nОныталмасам\nнишләрем\n",
"Баай-баай, утуй, чыычааҕым!\nСүлбээн-илбээн сүүстээх,\nХолбоон-илбээн хоҥоруулаах,\nМунньан-тараан муруннаах,\nИлбээн-холбоон иэдэстээх,\nХомуйан-имийэн кулгаахтаах.\n",
"Руй-руй, бай-бай,\nЗолотая моя гора,\nКаменная моя стена.\nНоги твои обгонят оленя,\nПальцы твои проворнее белки,\nГлаза твои не проглядят глухаря.\nОхотничью добычу будешь доставлять возами,\nУлов будешь привозить плотами,\nБудешь играть в городе серебряными рюхами,\nВ лапту будешь играть золотым мячом.\nЧерез пять городков будешь перескакивать,\nНад шестью городками седьмой выбивать.\nТы, мое солнышко, как посредине неба мерцающая звездочка,\nНа ладонях ты лелеянный,\nТы как тень у окна,\nКак куколка на коленях,\nДля дома ты большая радость.\n"
]

@title_adj = ["Волшебная", "Крутая", "Невероятная", "Лучшая", "Супер", "Amazing", "Вау", "Чудесная", "Добрая", "Хорошая"]

def seed
  reset_db
  create_admin
  create_users
  create_posts(15)
  create_comments(2..8)
  create_comment_replies(300)
  create_attachments(10)
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
    puts "User created with id #{user.id}"

    i += 1
  end
end

def create_admin

    user_data = {
      email: "admin@email.com",
      password: 'testtest',
      admin: true
    }

    user = User.create!(user_data)
    puts "Admin created with id #{user.id}"

    profile_data = {
      user_id: user.id,
      username: "Ваша Манурина",
      about: "Антропологиня класс"
    }


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

# def upload_random_image
#     uploader = PostImageUploader.new(Post.new, :post_image)
#     uploader.cache!(File.open(Dir.glob(File.join(Rails.root, 'public/autoupload/posts', '*')).sample))
#     uploader
# end

def create_posts(quantity)
  quantity.times do
    user = User.all.sample
    post = Post.create(title: "#{@title_adj.sample} народная песня", text: create_mashup(rand(4..8)), user_id: user.id)
    puts "Пост #{post.id} создан"
  end
end

# def create_attachments (quantity)
#   quantity.times do
#     attachment.url=
#   end
# end

def create_comments(quantity)
  Post.all.each do |post|
    quantity.to_a.sample.times do
      user = User.all.sample
      comment = Comment.create(post_id: post.id, body: create_mashup(2), user_id: user.id)
      puts "Комментарий #{comment.id} для поста #{comment.post.id} создан"
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

def create_attachments(quantity)
  Post.all.each do |post|
    rand(quantity).times do
      attachment = Attachment.create(post_id: post.id, url: "уррраааа работает")
      puts "Вложение #{attachment.id} для поста #{attachment.post.id} создано"
    end
  end
end

seed