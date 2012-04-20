class RubyBuild < Coresys::Formula
  url 'https://github.com/sstephenson/ruby-build.git', tag: 'v20120216'

  def install
    ENV['PREFIX']  = prefix
    system './install.sh'
  end
end
