class Mongodb < Coresys::Formula
  url 'http://fastdl.mongodb.org/linux/mongodb-linux-x86_64-2.0.4.tgz'
  digest :sha1, '14c8cd4c8c95015fd13e7fecfc014a39edc295b0'

  def install
    prefix.install Dir['*']
  end
end
