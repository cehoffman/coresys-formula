class Lake < Coresys::Formula
  url 'https://github.com/stevedonovan/Lake.git'
  version 'HEAD'

  def install
    bin.install 'lake'
    (bin + 'lake').chmod 0777
  end
end
