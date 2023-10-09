@raw_songs = ["Ты куда, голубь, ходил,\nКуда, сизый, улетал\nПо ельничкам, по березничкам,\nПо частому, по белому\nПо осинничкам.\nЯ ко девице ходил,\nЯ ко красной улетал\nПо ельничкам, по березничкам,\nПо частому, по белому\nПо осинничкам.\nКоя краше всех,\nКоя лучше всех.\nЯ ельничком,\nЯ березничком,\nПо частому, по белому\nПо осинничкам.\nИ белым она бела,\nИ румяным румяна.\nЯ ельничком,\nЯ березничком,\nПо частому, по белому\nПо осинничкам.\n", 
"Аклы ситса кулмәгемне\nЯкаларын кем уйган\nәй исеме Рәйхан\nкемнәр куйган\nСине лә куреп\nкем туйган\nәй исеме Рәйхан\nкемнәр куйган\nСине лә куреп\nкем туйган\nРәйхан бирде\nкулъяулыгы\nАлды биргән\nяулыгы\nәй алмады биргән\nяулыгы\nАлды йөрәгем\nсаулыгын\nАклы ситса кулмәгемне\nТабалмадым ишләрен\nәй гомерем буйларына\nРәйхан\nОныта алмасам\nнишләрем\nәй гомерем\nбуйларына сине\nОныталмасам\nнишләрем\n",
"Баай-баай, утуй, чыычааҕым!\nСүлбээн-илбээн сүүстээх,\nХолбоон-илбээн хоҥоруулаах,\nМунньан-тараан муруннаах,\nИлбээн-холбоон иэдэстээх,\nХомуйан-имийэн кулгаахтаах.\n",
"Руй-руй, бай-бай,\nЗолотая моя гора,\nКаменная моя стена.\nНоги твои обгонят оленя,\nПальцы твои проворнее белки,\nГлаза твои не проглядят глухаря.\nОхотничью добычу будешь доставлять возами,\nУлов будешь привозить плотами,\nБудешь играть в городе серебряными рюхами,\nВ лапту будешь играть золотым мячом.\nЧерез пять городков будешь перескакивать,\nНад шестью городками седьмой выбивать.\nТы, мое солнышко, как посредине неба мерцающая звездочка,\nНа ладонях ты лелеянный,\nТы как тень у окна,\nКак куколка на коленях,\nДля дома ты большая радость.\n"
]

def seed
  reset_db
  create_posts(10)
  # create_comments(2..8)
end

def reset_db
  Rake::Task['db:drop'].invoke
  Rake::Task['db:create'].invoke
  Rake::Task['db:migrate'].invoke
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

def create_mashup
  @mashup = []
  rand(4..8).times do
    @mashup.concat(generate_random_song(@raw_songs))
  end
  @mashup = @mashup.join("<br>").html_safe
 return @mashup
end
def upload_random_image
    uploader = PostImageUploader.new(Post.new, :post_image)
    uploader.cache!(File.open(Dir.glob(File.join(Rails.root, 'public/autoupload/posts', '*')).sample))
    uploader
end

def create_posts(quantity)
  quantity.times do
    post = Post.create(title: "невероятно", text: create_mashup, post_image: upload_random_image)
    puts "Post with id #{post.id} just created"
  end
end

# def create_comments(quantity)
#   Post.all.each do |post|
#     quantity.to_a.sample.times do
#       comment = Comment.create(post_id: post.id, body: create_sentence)
#       puts "Comment with id #{comment.id} for pin with id #{comment.post.id} just created"
#     end
#   end
# end

seed