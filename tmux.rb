class Tmux < Coresys::Formula
  url 'http://sourceforge.net/projects/tmux/files/tmux/tmux-1.7/tmux-1.7.tar.gz'
  digest :sha1, 'ee6942a1bc3fc650036f26921d80bc4b73d56df6'

  def install
    system './configure', "--prefix=#{prefix}"
    system 'make', 'install'
  end
end
