class Vim < Coresys::Formula
  url 'https://github.com/b4winckler/vim.git', tag: 'v7-3-789'
  homepage 'http://www.vim.org/'
  version '7.3.789'

  def install
    system './configure', "--prefix=#{prefix}",
                          "--mandir=#{man}",
                          "--enable-gui=no",
                          "--without-x",
                          "--disable-nls",
                          "--enable-multibyte",
                          "--with-tlib=ncursesw",
                          "--enable-pythoninterp",
                          "--enable-rubyinterp",
                          "--with-features=huge"
    system 'make'
    system 'make', 'install'
  end
end
