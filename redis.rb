class Redis < Coresys::Formula
  url 'http://github.com/antirez/redis.git', tag: '2.4.10'

  def install
    system 'make', 'install', "PREFIX=#{prefix}"
  end
end
