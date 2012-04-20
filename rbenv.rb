class Rbenv < Coresys::Formula
  url 'https://github.com/sstephenson/rbenv.git', tag: 'v0.3.0'

  def install
    prefix.install Dir['*']
  end
end
